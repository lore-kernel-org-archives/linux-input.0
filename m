Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28873E9F93;
	Tue, 25 Aug 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652581; cv=none; b=WpTTjxYRZIT7crvAbcg4M0pUKQgHj7kTHxuTK0xBusBtfFKMVTER0S/sVI0fiUOp4VdU+dOeO0WEHtnuJhX5e8BCxB2flFS7VfUOEzENlZ8/RTDPv/5nQmEXtdLKF1CNG8TLTxpZQtzCNsFDWEPGzY87sb0CbOXr6GjJUOukaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652581; c=relaxed/simple;
	bh=nz39AJYxBtpSBlMvja6UqpL7HVQWUrhfdvIJ/jdncT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=auAvVtLbBARzZxZNbwBYFo0UpXOAjWt2q325U+6WS3zfrzQIdUWU4MHPX9cpVKkbZViCMZhwyB+ZChwJJq7QOVpTy9oVjffGqYbnZLukF1Flz5WxgrW1A26A7K33fai0rzlMPTLbkI1W441Uuun3BIBqv/gvek2981Y1xfGAXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1ADOhGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1ADOhGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB791F000E9;
	Tue, 25 Aug 2026 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787652580;
	bh=veIVyHSw4YI1fAcSwJqVgRMnqo++Va4vwbz9uMvQgZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1ADOhGRV8kLsE8saQjxahzlm8eVCzyfdlGUCcJ2bRE2+xtUog99o4gYA9Q8MDBGW
	 04PVHLqNRlLjFnF/0brDMxf1qpoG1SRnBEKmT5Wzx39vFgX4biYiZQ9z+i81CdSO0J
	 i0Bm9p9MgHuGVqplLtEDid1rCVRfULG6ju5O8JD7B33/2LE+BPV6sLmwh/qz/GwhxN
	 ZPkiBkSQ6p323G1B3yPeoVBeukJA6z2P3JdzpdIvYCpsY3QEck0pKfybhCH6QpGANW
	 qDajNohMZRldSC6v9jz8M0khx1F6vnIIenNt053hUVFyEkDRJH7PLcnk2fqKM2Acm8
	 C2y6ZLIjd/Ftw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] selftests/hid: prepare
 test_rdesc_fixup_get_data_overflow for the new verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Tissoires" <bentiss@kernel.org>
Cc: bpf@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825-wip-bpf-safe-v2-3-d044355c09d8@kernel.org>
References: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
 <20260825-wip-bpf-safe-v2-3-d044355c09d8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:09:39 +0000
Message-Id: <20260825100940.1BB791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The test silently passes on any program load failure, masking un=
related infrastructure issues.

Pre-existing issues:
- [High] Using TEARDOWN_LOG with ASSERT_OK_PTR causes FIXTURE_TEARDOWN to e=
xecute twice, leading to undefined behavior (double pthread_join).
- [High] Teardown deadlock with uhid background thread on assertion failure.
--

--- Patch [3]: [PATCH v2 3/3] selftests/hid: prepare test_rdesc_fixup_get_d=
ata_overflow for the new verifier ---
commit 2045d9e4296113259f889a7b753ecfe091d15ecf
Author: Benjamin Tissoires <bentiss@kernel.org>

selftests/hid: prepare test_rdesc_fixup_get_data_overflow for the new verif=
ier

The new verifier in the bpf-next branch is now capable of detecting the
overflow that was triggered by test_rdesc_fixup_get_data_overflow.
This is better in terms of UI, but now the test is failing and should be
marked as expected to fail.

Add a new parameter to load_programs() when we expect the test to fail,
and dynamically validate the test by checkcing if it loads (it should
fail to load with new verifier), but if it still loads, HID-BPF should
detect the overflow itself and return an error in hid_bpf_get_data().

> diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selfte=
sts/hid/hid_bpf.c
> index 069ebdbb4d1c4..7ab86296ff236 100644
> --- a/tools/testing/selftests/hid/hid_bpf.c
> +++ b/tools/testing/selftests/hid/hid_bpf.c
> @@ -67,14 +67,17 @@ struct test_program {
>  	int insert_head;
>  };
>  #define LOAD_PROGRAMS(progs) \
> -	load_programs(progs, ARRAY_SIZE(progs), _metadata, self, variant)
> +	load_programs(progs, ARRAY_SIZE(progs), false, _metadata, self, variant)
> +#define LOAD_PROGRAMS_MAY_FAIL(progs) \
> +	load_programs(progs, ARRAY_SIZE(progs), true, _metadata, self, variant)
>  #define LOAD_BPF \
> -	load_programs(NULL, 0, _metadata, self, variant)
> -static void load_programs(const struct test_program programs[],
> -			  const size_t progs_count,
> -			  struct __test_metadata *_metadata,
> -			  FIXTURE_DATA(hid_bpf) * self,
> -			  const FIXTURE_VARIANT(hid_bpf) * variant)
> +	load_programs(NULL, 0, false, _metadata, self, variant)
> +static int load_programs(const struct test_program programs[],
> +			 const size_t progs_count,
> +			 bool load_may_fail,
> +			 struct __test_metadata *_metadata,
> +			 FIXTURE_DATA(hid_bpf) * self,
> +			 const FIXTURE_VARIANT(hid_bpf) * variant)
>  {
>  	struct bpf_map *iter_map;
>  	int err =3D -EINVAL;

[Severity: High]
This is a pre-existing issue, but does using TEARDOWN_LOG with ASSERT_OK_PTR
inside load_programs() cause FIXTURE_TEARDOWN to execute twice?

If hid__open() fails in this function and returns NULL:

tools/testing/selftests/hid/hid_bpf.c:load_programs() {
    self->skel =3D hid__open();
    ASSERT_OK_PTR(self->skel) TEARDOWN_LOG("Error while calling hid__open");

ASSERT_OK_PTR() evaluates as false and executes its optional handler
TEARDOWN_LOG(), which directly calls hid_bpf_teardown() and pthread_join().

Afterward, the kselftest_harness __bail() mechanism triggers the test
framework's wrapper teardown:

tools/testing/selftests/kselftest_harness.h:wrapper_##fixture_name##_##test=
_name##_teardown() {
    if (fixture_name##_teardown_parent =3D=3D in_parent && \
        !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
        fixture_name##_teardown(_metadata, self, variant); \
}

Since _metadata->no_teardown wasn't updated by TEARDOWN_LOG, this calls
hid_bpf_teardown() a second time. Can this result in undefined behavior
crashing the test runner child process via a segfault?

[ ... ]

> @@ -904,7 +911,9 @@ TEST_F(hid_bpf, test_rdesc_fixup_get_data_overflow)
>  		{ .name =3D "hid_rdesc_fixup_get_data_overflow" },
>  	};
> =20
> -	LOAD_PROGRAMS(progs);
> +	/* newer verifier can detect the overflow at load time */
> +	if (LOAD_PROGRAMS_MAY_FAIL(progs))
> +		return;
> =20
>  	ASSERT_EQ(self->skel->bss->get_data_overflow_check, 1);
>  }

[Severity: Medium]
Does returning on any load failure silently mark the test as PASSED?

If hid__load(self->skel) fails for an unrelated infrastructure reason
(e.g., -ENOMEM), load_programs() will return that error code and make
LOAD_PROGRAMS_MAY_FAIL(progs) truthy. The test then executes a normal
return, exiting with a 0 status.

Should the test instead verify that the program was specifically rejected
by the verifier with the expected error code?

[Severity: High]
This is a pre-existing issue, but is there a potential teardown deadlock in
test_hid_user_output_report_call() on assertion failure?

If an assertion fails while the main thread holds uhid_output_mtx:

tools/testing/selftests/hid/hid_bpf.c:test_hid_user_output_report_call() {
    pthread_mutex_lock(&uhid_output_mtx);
    ...
    ASSERT_EQ(args.retval, 3);
    ...
    pthread_mutex_unlock(&uhid_output_mtx);
}

The test executes __bail() and initiates teardown without releasing the mut=
ex.
Teardown sends a UHID_DESTROY event and blocks on pthread_join(self->hid.ti=
d).

Concurrently, the listener thread might process a UHID_OUTPUT event:

tools/testing/selftests/hid/hid_common.h:uhid_event() {
    case UHID_OUTPUT:
        ...
        pthread_mutex_lock(&uhid_output_mtx);
        ...
        pthread_mutex_unlock(&uhid_output_mtx);
        break;
}

Does this cause the listener thread to block indefinitely attempting to
acquire uhid_output_mtx, which in turn causes pthread_join to hang in the
main thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-wip-bpf-sa=
fe-v2-0-d044355c09d8@kernel.org?part=3D3
