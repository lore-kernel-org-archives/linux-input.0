Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2C17A300
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785630313; cv=none; b=LLNjZe1OSLp3e1x9CFEDWAlMxC19a2owVi0C1SHvNdEYFaEOq0hI+0qjDbJjbYLYS4/6Cr2BocPHE0QII4WHMAkbUne0iPWXQO28KcFL85bYprf5OOto0pf+EbpOzArKyJ5mTRZy4BIdOry9vV3yVBFNi5ttD3rq15TG2g50r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785630313; c=relaxed/simple;
	bh=5PnSmekTWi20lc9XfRoOoPQ2Wk/A9//JYD9RvL7+rkE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=mhnN4Khf9fmDRFv5ETx8m0B2fpQdoTZohrMF5N260mk2n8Dyj8DYNo3oroa8qVpFWjAgRjCblFPAiu+ivB098OyV4ifV2EPj1mRhYYKAuFFrK1C3CQkbWNOpSjBHJWWMj6c/FOgPncT1D+t+DbhoumTuB54ZfO8POzZwEf34tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=Tm8QQ4se; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Esx/JCjx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="Tm8QQ4se";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Esx/JCjx"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Tm8QQ4se3cUboXQa/U7BkNdsQv1VReILZqBBaorZ/2PRPI0Uf9jazbxLeoG3rB4BW53qEW9XaLDUDzlDXAU4vwB14yuReH/VaAa2k8g/CONHvjtz1tfDrne6nypK9MAeeZ2l9jtOMWu/zLsQyGVq/FdflZYoEQ9V3e9XF47EFLsByeT/CwPk2A7fNDFLhch9vbXax3DGyY2GmyRUVoBv/Q4Vwyva0cSytkvtFzaDfx3SfuRTro4lEl8yWaz5IPiSDyCiYR/JIvT0QRGVIqwAPcs4KaZnMKpmAg+g9m34K8SLofuL1IFNfSrr9DsXqyKeg/A4QCFOF3j1VTz/Lb/SQw==; s=purelymail1; d=rcpassos.me; v=1; bh=5PnSmekTWi20lc9XfRoOoPQ2Wk/A9//JYD9RvL7+rkE=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=Esx/JCjxAJGO6iesbW4Ld4vy/mHaGoqgl2WK0i8/U7yIayMBnnuq8/1aOayeBiP2FGioqq5Fy2jb6Q+2ONt+Wjq5Tff72mrAHTNjr5RXd3MdbJWeZXQvMoL5b3Rhyx5EUF3E3F6kggFVYkHtwXauWitd8j0JojD1ysEXzy5jrF7q92GlN74l+5u8vXz+xeahuHkpzPRGe1pzcOWaGrzMG/l21q3eCyU2mdH3vRBePXuh57xkX21LSKJFql7LY83bIvfPA0fz5oxHERfLkDTuDpQRx47TIqORQvpJfSu8xhfOa3WoE6+UPn9E7zduZoKjz6uncog2JPOmKkXVi869Kg==; s=purelymail1; d=purelymail.com; v=1; bh=5PnSmekTWi20lc9XfRoOoPQ2Wk/A9//JYD9RvL7+rkE=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -285589192;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 02 Aug 2026 00:24:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 21:24:50 -0300
Message-Id: <DKE13Z04GD3M.1AMEVQ7XTSAB5@rcpassos.me>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "David Rheinsberg" <david@readahead.eu>, "Rafael Passos"
 <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>
Subject: Re: [PATCH v3 3/4] HID: wiimote: use scoped cleanup in wiimote and
 led probes
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-4-rafael@rcpassos.me>
 <42b2b3bf-a165-4caf-a746-0c37bfa925a2@app.fastmail.com>
In-Reply-To: <42b2b3bf-a165-4caf-a746-0c37bfa925a2@app.fastmail.com>

On Fri Jul 31, 2026 at 8:18 AM -03, David Rheinsberg wrote:
> Hi
>
> On Wed, Jul 29, 2026, at 6:49 PM, Rafael Passos wrote:
>> Cleanup code in wiimote/led probe function, using the scoped cleanup.
>> This prevents mistakes in future changes to this function.
>>
>> In wiimote_probe_clenaup, a few functions are safe to call without
>> checking. For the hid_hw calls, a new bit mask was introduced to track
>> probing state.
>
> Is this patch worth it? the led-probe looks ok, but the wiimote_probe() c=
hange looks convoluted. If you really want to go that route I would prefer =
if you reuse wiimote_destroy() and ensure it checks for the right condition=
s, rather than adding __wiimote_probe_cleanup().
>
> Thanks
> David

That's a good point.
I will try merging the cleanup and destroy functions.
If it is still not good, we can just go back to the v1 for this commit.

Thanks,
Rafael Passos
