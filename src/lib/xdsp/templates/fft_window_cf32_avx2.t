static
void TEMPLATE_FUNC_NAME(wvlt_fftwf_complex* __restrict in, unsigned fftsz, float* __restrict wnd,
                        wvlt_fftwf_complex* __restrict out)
{
    const __m256i sh0 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    const __m256i sh1 = _mm256_setr_epi32(4, 4, 5, 5, 6, 6, 7, 7);

    for(unsigned i = 0; i < fftsz; i += 16)
    {
        __m256 e0 = _mm256_load_ps(&in[i +  0][0]);
        __m256 e1 = _mm256_load_ps(&in[i +  4][0]);
        __m256 e2 = _mm256_load_ps(&in[i +  8][0]);
        __m256 e3 = _mm256_load_ps(&in[i + 12][0]);

        __m256 w0 = _mm256_load_ps(&wnd[i + 0]);
        __m256 w1 = _mm256_load_ps(&wnd[i + 8]);

        __m256 dw0 = _mm256_permutevar8x32_ps(w0, sh0);
        __m256 dw1 = _mm256_permutevar8x32_ps(w0, sh1);
        __m256 dw2 = _mm256_permutevar8x32_ps(w1, sh0);
        __m256 dw3 = _mm256_permutevar8x32_ps(w1, sh1);

        __m256 r0 = _mm256_mul_ps(e0, dw0);
        __m256 r1 = _mm256_mul_ps(e1, dw1);
        __m256 r2 = _mm256_mul_ps(e2, dw2);
        __m256 r3 = _mm256_mul_ps(e3, dw3);

        _mm256_store_ps(&out[i +  0][0], r0);
        _mm256_store_ps(&out[i +  4][0], r1);
        _mm256_store_ps(&out[i +  8][0], r2);
        _mm256_store_ps(&out[i + 12][0], r3);
    }
}

#undef TEMPLATE_FUNC_NAME
