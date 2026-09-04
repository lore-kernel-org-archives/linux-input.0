Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C04A2073;
	Fri,  4 Sep 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531650; cv=none; b=T65IJLTsLFTGqbE9Bcqul86rlgcUygKf0iucb6g7SnxVuvfZJ/Nab3qMW5gV31uMMsVMCwDIhJ/nKg+uQr8ibZrQT2fdCacTNcmMQNIGpufI+/djvQz+Nhrpgeor4AACf/Td5k1qP0ZghT3JY3zoW+6vMJELx7fs+HJaotVQb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531650; c=relaxed/simple;
	bh=AuTmEzxxURAuJP0bku/Sueex2DK8EZqzKt4IBcwT27Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaPZI6tmmcdLIe+Hx5R6JK7Vfervxu1J7pPDdkmTgHBD+PkTa7/EtMBbrduulSzjQG4DdLwC4GBT4u8oyjUFFV3D3nCeOn/13iKFGWlZ45NolgjDKzCP1gzN+X13c3wxFmnCfmmugBTG/7Xxlx2644ful2nutDIDSXCyl1jdPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+2grNfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+2grNfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F418E1F00A3D;
	Fri,  4 Sep 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531647;
	bh=NzZFOd7YeRa3ZlfRWDGxttIq9XTYP4RaNmU6dAcsR8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+2grNfoAJ+Q0nZWA9tERZt/Rz33eLr7OmlkqimygFiZZ6mgUX0Se71wwz+oT7Sqh
	 aqi+flnsf8MWiMG7jjovoPD9QpCU73enIiNkWjJMavZIXlKxrvYQeGztzQ3Uy33xGI
	 Kk2u6JJ94o8xX0gZgGaJf1P6cq2TqSEpsdzXxPC9SMrHZlf+iJpZ+SVOlOqVNE0IfW
	 LYzwiU3lWuRc1GBO0cPRErUWhsmSbWtTLdT5g+fzdfGyM0z1ps9bhWqpsRlRx8xoxO
	 f8dQZ0/COrQIGViA1TNyPLJ3qSMT0KVHwPlN8hmbe50+Yr7nTrQHCiP7840zQOh1w3
	 gY4pLKZmeWhvQ==
Date: Fri, 4 Sep 2026 16:20:44 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH 3/3] selftests/hid: add unnumbered variant to the hid_bpf
 tests
Message-ID: <aprTPp1eY2VqONyV@beelink>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
 <20260904-wip-bpf-check_report-v1-3-efe9a2a1ed28@kernel.org>
 <20260904131250.D84C31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904131250.D84C31F00A3D@smtp.kernel.org>

On Sep 04 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added unnumbered test variant runs against unadapted tests, leading to test suite regressions and false passes.
> --
> 
> commit 25b4cfc0df88875655d4c7a83e9318718c0ae97f
> Author: Benjamin Tissoires <bentiss@kernel.org>
> 
> selftests/hid: add unnumbered variant to the hid_bpf tests
> 
> A bug appeared in hid_bpf_dispatch.c where it wasn't properly handling
> unnumbered reports. Add a device variant without report IDs so we can
> also test them.
> 
> > diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
> > index e865ee55b4f1d..d1bd07caf9919 100644
> > --- a/tools/testing/selftests/hid/hid_bpf.c
> > +++ b/tools/testing/selftests/hid/hid_bpf.c
> > @@ -54,11 +54,27 @@ FIXTURE_TEARDOWN(hid_bpf) {
> >  	hid_bpf_teardown(_metadata, self, variant); \
> >  } while (0)
> >  
> > +FIXTURE_VARIANT(hid_bpf) {
> > +	__u8 *rdesc;
> > +	size_t rdesc_size;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(hid_bpf, numbered) {
> > +	.rdesc = rdesc,
> > +	.rdesc_size = sizeof(rdesc),
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(hid_bpf, unnumbered) {
> > +	.rdesc = fido2_rdesc,
> > +	.rdesc_size = sizeof(fido2_rdesc),
> > +};
> > +
> 
> [Severity: Medium]
> Will unadapted tests such as raw_event() and
> test_hid_filter_raw_request_call() fail when run against this new unnumbered
> variant?

If they would have failed, I wouldn't have sent the series :)

> 
> Since FIXTURE_VARIANT_ADD registers this variant for all tests in the hid_bpf
> fixture, tests that weren't adapted might now fail because they still hardcode
> assumptions about the 6-byte numbered report. For instance, raw_event()
> expects exactly 6 bytes:
> 
> 	err = read(self->hidraw_fd, buf, sizeof(buf));
> 	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
> 
> test_hid_user_raw_request_call() hardcodes a report ID of 1:
> 
> 	args.hid = self->hid.hid_id;
> 	args.data[0] = 1; /* report ID */

report ID is a convention, but if there is no report ID, then it's just
the first byte.

> 
> And test_hid_filter_raw_request_call() injects a 6-byte event:
> 
> 	buf[0] = 1;
> 	buf[1] = 42;
> 	uhid_send_event(_metadata, &self->hid, buf, 6);
> 
> Do these other tests need similar if/else logic for variant->rdesc, or
> should they explicitly call SKIP() for the unnumbered variant like
> test_rdesc_fixup() does?

It works, because uhid is lazy enough to not check against the report
descriptor and just forwards what goes in. So we are just checking the
kernel is not tampering with the data.

Cheers,
Benjamin

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org?part=3
> 
