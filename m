Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793629102;
	b=ygMCmBdAh9WBzfVc/HbbWLO1j46kUTHroBqoL2avruNYNyWWghYj0EbLgyrIT2hH3cjK
	 1ZpLcpcN8N7PMuH3ywO3fGSL5by81CPssOiuwPdnSWqTnvFoJtL0AYHQx1BhZVW/Yv/c2
	 W+Vg3utSRqLVmpwIiuk2XuaihoaEhBv+RZpxI6scLRtoMALRg+uJK4xVblw/1YvEPy7aN
	 o4pMjG+rUrtyzwWnL1u3KIi5iX20Ht9GJ1kmxrB2fBvQsyKYmt7E3xNZkYUe8mFhMJGj1
	 Kar6sm8Yb7AkOxcvH3yPrsfnLYpwZ679fcm9fcR+DA1ih+wq0OTupooT6EGgRwr/bAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1RjcRhzwmQTEwl1HX0Rcpr8H7X1jrpm5LzpMX36K/ho=;
	b=e45yrC7W7WQF7D6RoBa39CGw1WvDffH8xAGh1X32tVs7MZa1cb44d8/hfIrdfw6xXvVg
	 7FYo3U6Zzt/NwHSHWVGDtBUloWNWtObX/rALJPCo1Sq5Oj5aMhPG3WGtzvUMur1fwtxZo
	 pWbTKFt0T0Va+GdhYHsDbLiEQDP2+Rn9bPQGxgKJoMencMRIeh6WNVi/qrpiypKQa8Z1u
	 tqSUy8Vo6bUZHqxZt5uF74gWvWVPptSXeVerD5McDTPHixvVnYpXknDNTmDNhnBdfl9AP
	 bs5NxJ0fSZopBtSLR1inbGfHdjj4ZPDB+0eYBwJeTKIARb8gqTQBsk4Lsc4/Yv2OhtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWxyEISk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02216606A327
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 14:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02216606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWxyEISk
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53bb57f1310so41173591cf.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 06:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793629101; cv=none;
        d=google.com; s=arc-20260327;
        b=hPV+avcQQ+RImPKKIHy/+ZgICDy2lQ+hD10eAGlZdpkTvJqsxB14Y5VzCbZBZK+R/D
         7tIxsgqB0nhLMx8dhHrhpaH+PDLMHgUByNx5VS8m9cGxVnlVXqWfaw1WkHfG5ptkdlZ0
         cZMR5F2sDEZDlsmdtLSzkQkL5hhq2ZWV4R0WEFVeikSXjRvhojKniSI94C4t3hkD5qmu
         j2ovpaDvaHA2FQMnGb+h1qa/rlOMdEUv5bjDwjczlEM/Ej1iKCzR/DmkV+JyX1UxgCEf
         KPMP2ZTvcadan2wmrjxEwHGVoR5tQT7uJlzSJle5KWzmN56J4/nKBmLqn1XX4cq9fj/L
         JCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RjcRhzwmQTEwl1HX0Rcpr8H7X1jrpm5LzpMX36K/ho=;
        fh=le9SwmY6Lfmjl49PB1bANri77HfmBL/4mMrGxEAeFl4=;
        b=KYtJhyHYMiSmXVq2V6u2sP9s1bte2Ia6I/IR21so0DsWGHlls6VzRIH1+q3sxl+6hG
         XNjurXyX/ObiA4NAOYg5VY/etxXjLnV7Xy7lrXbYAUfgQcVZv8OhFe31AKpAZwUAW3it
         nNrpQO1nJLdzNL3VZaiPhaVITegB3eYTKToTW6rLWAD1Ywh3qG0WB8NXhxAPUl6/g4fr
         FsMZJZrv5Kc64/gUB4yd89Bt2UbKi3KWdU940pBETAW5vOBBc+gH211If5dqByZCGFwm
         xz+4kvv+2HlEzOE+RysKe3XG9XAO1y+uu2Slw4rF6AQSfOF9+E3SQbQ/dAKpa1/zBxzH
         z9ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793629101; x=1794233901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RjcRhzwmQTEwl1HX0Rcpr8H7X1jrpm5LzpMX36K/ho=;
        b=OWxyEISkGGtfxeddi5bhegsKbmqfILIic23rjXA16NDYVauktW4u/bsxb9JaNmb9Jf
         yG2cHsYjrX4MpbmK5upzaL49koyQMTlDM7/5QfKLbBCAwbAfil8MYtMLrvQv0yBuvm/t
         RyQr2KAG10UhN9M6I3yJd/bHqPyvD/jLWNqCzIqA1mRTnEYH8SH4zt8BF8zJsF43xs3+
         yBXarDQBiBZcLn6A+P29AcAyJQkw2yA2Wted1rB3rijiIWyk9yxSw8o9qCH4eQ3xuIIn
         tYi5xoXwdXAcab/+16nyCNUjwNfLsT6C+jQPtXsycf+UuWx4/K5sFIr7vxeym46ExfF2
         36NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629101; x=1794233901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RjcRhzwmQTEwl1HX0Rcpr8H7X1jrpm5LzpMX36K/ho=;
        b=R2IYyKMKjA+/NruIa6exP4aE35i1NhC9087Lrb/BYq4sbMxATQpKsIfsoBu+/OGNTH
         R7P0BwoZpbQ4+hqUH2uqVLl1YKRXFWemrTF0hunmvOsmhYferQy50RRXbNMx5RCG/ojc
         6Zd+QVVrgd4YSvlkB2wAuYcrJOkaR2smyJIpb56eNPvlo7rQIU6WVT0xGbmIjVRlqDFM
         mu9i8hJ4A6J53kznql2ux/EczxCkSsFgVYMtI60ZMVtHIEZ5hqXpJC4P+MtYhd/+GpsM
         saJ2dFLep+Na1wGDGmabrDx2YAcY8/cwMWtFyIqJGVjZdWXmGr9gQLVSxzs605zuiYTn
         mNng==
X-Forwarded-Encrypted: i=1; AKwUvBzVcnososXoYuy+snntm3/Sc18yHM9EbIWWfA3Gk0r/27k3Qw/RgnIYmPuPS4Hnq3FwcUE8sUEUdoSJzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z912zBDLVGwprsZ0wug8l0Bf9S7QEv3knWOl9yfFydPhMqtf9ni
	IsgmmDJM58Jwh4NFnHrS1DtYQKt3VgTmZ+vkFVGeg5137avPDBgYefD0bRzhCOnZIWPujsMp9pU
	pD1ZlQdnbYT7BZuCnq7JMeDtDjLICer4=
X-Gm-Gg: AYBFou2dc58YQm2HI0oXtJmKHHInu3FWTiPtkap2qCn00exODCXlVg3GC0bi25AnliF
	CSUQqpCUinUoPaHwj68yIGufaE6Gvm4lso12XytEbWNlUEGWn6xP3eQxXpKDHFfjUC9t2kYlO4x
	mFW/lzyiqay2XYdWOAxQKZggW/jY/DVUuP3hyc3ocCCmVaqN4WSn7PbUtKa/golES5nn5j6bppj
	PUwD4CXOKvAU015P9dYnsW2ABPKgvdCNH7lSzRuC1C/ov5L/5jOTRUnvT8VXvR0k6P2DQkdwSTp
	dhGfXD6XQYNb1FwGjgQa8/FBHw77lu1jkvXFrMK9EBLHjkHx8/w7n/acwWUdtkq6Cs6pfEt69fo
	aA8sYjzLJtevf/hxIV7Fa2GXdUktgWrFkzLpC4A==
X-Received: by 2002:ac8:5708:0:b0:536:6378:c80d with SMTP id
 d75a77b69052e-542b6f50532mr162652461cf.32.1793629100726; Mon, 02 Nov 2026
 06:18:20 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-hid-playstation-ratelimit-input-crc-error-v1-1-68812542f898@igalia.com>
In-Reply-To: <20261027-hid-playstation-ratelimit-input-crc-error-v1-1-68812542f898@igalia.com>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 2 Nov 2026 06:18:09 -0800
X-Gm-Features: AclHuK-Aber4nLkeUJuI-VHoMCJBO8DQ3A0k5lW5zzgYbYlbxJNc2hnEU0K54f8
Message-ID: <CAEc3jaA_DhowgjeEBJGsUd2-SSWeDkvLbjFJsMeSSWgEqGc04g@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: ratelimit input CRC check failed messages
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, kernel-dev@igalia.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mauricio,

This looks reasonable to reduce log spam.
Signed-off-by: roderick.colenbrander@sony.com

Thanks,
Roderick Colenbrander



On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> The kernel log of a Steam Deck was mostly filled with CRC check errors
> from what is apparently a bogus controller, with 8174 messages in <200
> seconds, averaging ~43 messages/second:
>
>     $ cat dmesg-pstore.202610250608-0 \
>       | grep -c "input CRC's check failed"
>     8174
>
>     $ cat dmesg-pstore.202610250608-0 \
>       | grep -m1 "input CRC's check failed"
>     <3>[    8.715455] playstation 0005:054C:05C4.0006:
>                       DualShock4 input CRC's check failed
>
>     $ tac dmesg-pstore.202610250608-0 \
>       | grep -m1 "input CRC's check failed"
>     <3>[  196.187459] playstation 0005:054C:05C4.0006:
>                       DualShock4 input CRC's check failed
>
>     $ echo $((8174 / (196-8)))
>     43
>
> Let's ratelimit the input CRC check failed messages for the exceptional,
> high-frequency error case, which doesn't impact the occasional, low-freq
> error case (as ratelimiting does not trigger) or the non-error case.
>
> CRC check failed messages for driver-initiated requests are kept as is.
>
> Testing with a UHID driver to synthetically reproduce input CRC check
> errors (generated by an LLM) shows that it reduces the duplicate lines
> and still provides useful information (number of errors/same message).
>
> For example, triggering such error every 25ms (40 times/second), prints
> 10 messages and silently counts another 187 in 5 seconds, ie, 197 / 5 =3D
> 39.4 times/second (aligned with the synthetic reproducer's rate):
>
>     [    9.554184] playstation ...: Registered DualShock4 controller ...
>     [   10.053936] playstation ...: DualShock4 input CRC's check failed
>     [   10.078162] playstation ...: DualShock4 input CRC's check failed
>     [   10.103447] playstation ...: DualShock4 input CRC's check failed
>     [   10.128739] playstation ...: DualShock4 input CRC's check failed
>     [   10.154016] playstation ...: DualShock4 input CRC's check failed
>     [   10.179198] playstation ...: DualShock4 input CRC's check failed
>     [   10.204474] playstation ...: DualShock4 input CRC's check failed
>     [   10.229762] playstation ...: DualShock4 input CRC's check failed
>     [   10.254904] playstation ...: DualShock4 input CRC's check failed
>     [   10.280441] playstation ...: DualShock4 input CRC's check failed
>     [   15.070695] dualshock4_parse_report: 187 callbacks suppressed
>     ...
>
> This reduces the space consumed in the kernel log during 5 seconds from
> ~200 lines to only 11 lines (5.5%).
>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> ---
>  drivers/hid/hid-playstation.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index f9dc9378cf777d33aab3cdb87302c6e48f406d2f..b053037a3f0b95b6986c7e53e=
787e005676ed565 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -824,6 +824,7 @@ static int ps_get_report(struct hid_device *hdev, u8 =
report_id, u8 *buf,
>                 u32 report_crc =3D get_unaligned_le32(&buf[crc_offset]);
>
>                 if (!ps_check_crc32(PS_FEATURE_CRC32_SEED, buf, crc_offse=
t, report_crc)) {
> +                       /* hid_err_ratelimited() not used on driver-initi=
ated requests */
>                         hid_err(hdev, "CRC check failed for reportID=3D%d=
\n", report_id);
>                         return -EILSEQ;
>                 }
> @@ -1459,7 +1460,7 @@ static int dualsense_parse_report(struct ps_device =
*ps_dev, struct hid_report *r
>                 u32 report_crc =3D get_unaligned_le32(&data[size - 4]);
>
>                 if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, =
report_crc)) {
> -                       hid_err(hdev, "DualSense input CRC's check failed=
\n");
> +                       hid_err_ratelimited(hdev, "DualSense input CRC's =
check failed\n");
>                         return -EILSEQ;
>                 }
>
> @@ -2425,7 +2426,7 @@ static int dualshock4_parse_report(struct ps_device=
 *ps_dev, struct hid_report *
>
>                 /* Last 4 bytes of input report contains CRC. */
>                 if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, =
report_crc)) {
> -                       hid_err(hdev, "DualShock4 input CRC's check faile=
d\n");
> +                       hid_err_ratelimited(hdev, "DualShock4 input CRC's=
 check failed\n");
>                         return -EILSEQ;
>                 }
>
>
> ---
> base-commit: 83f32c773255720a661aa45d83e36278135f23f5
> change-id: 20261027-hid-playstation-ratelimit-input-crc-error-26f871f1c9d=
2
>
> Best regards,
> --
> Mauricio Faria de Oliveira <mfo@igalia.com>
>
>
