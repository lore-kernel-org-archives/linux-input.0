Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43227FB1F
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349937; cv=pass; b=FvQmxSRLTdZJXQ/dGjWg0scltWY8A4cajJm5JOLp92c+hAIf0f0YY6skB5Vg4OQkgPM/m+a4RMleoBccrWJh0G+nL1mu0K/kzYHij2RySZmSdjMRrOkTlxPDAJPeBXZ62UGeA0vD3jq9+zfwtKq72UxaguYQTsnBTWB/ga5WAQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349937; c=relaxed/simple;
	bh=9xTat86ZHK5zDlLwjXBVdCkNB988EHIwokmlOjoulAw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DotbicPCnobR+GM1DFvWzgZemG6xTjA6Mx2wyGfGCAeH/sGmsCpMdKmB4xlVyUmUIkzRumGj12Tcdp1rQ1OQ1b0ScyOsGdyX+mb4pIQxgIbHaByfvm/qDDmI++r7OoiU/A3K1BKtzSl4usg4+A3tVjpBTmhVXkHkxq6pQQZ9cb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNzd5u24; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNzd5u24"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79495b1aaa7so110864107b3.1
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 21:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777349936; cv=none;
        d=google.com; s=arc-20240605;
        b=JjUculMr12Jbu+buhWKIUlqJE4WejkQGydwX6E34tsGT3igzgsnBOFAwxIftOYcIHi
         oCbV5wKL8uTcqkNfZDuJg1BugIf4xjbi8Gw5n0PVLlF4mOIVyxV5cHtF+M8pfLJkFhbw
         wKuR4QW9EEmdFZrhlVs2qyv4KbHWE50x0CcABFMrmaLB1B1ILaLzze1ixZsH4jsGzyDV
         cZRXQ6bdRAonMWWzaWR904UjontDdE2BIjG4lFp8Zat0wmaDvZSIRpjAPpvKjc1fkB/e
         Ii3QbIidg0o8ehnGKL/wcaH/YMGz/MGkxaVNGwUDrJuBiP7KnZAdiy9WYaYKGg3kdnu8
         7kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1kHYMN2hdrkh8km3xuB3DZPgiACrDlk18Lyz165PNqs=;
        fh=On0FlpeAXZW6i6EK2bPFR7t02H5LEFG7rvNLtIaW+OI=;
        b=gwYDW2d5O0UrfD+U0MiT+htVF3vMJZTDSQEMbuUxcUb6eHGWHelSkHTeQ92Hh1vAi+
         DE3M90WFy8b+mVj+Ozs5QbNMbAs1QYtHnwpv84r1uMbJRzklIZWvtDpnqT9zZwAn80fk
         Ktljn+2hV/2AaUWv7C0F1RBkp9G1edGBIic7yLGQnzXZG9FtqgcohWFHjiYuKXlc1rAR
         crKN14MkI4wKokZcvkxCrVGXdDEIVra4kF6dINcXvfDSWQhD3u3vYQVPWXMMEXVitGgR
         JoyKRA7ZavNDOUy+2222nInhYxaGep6gI+Tb4J7RqvHJNRaca0IsA48ViLxHYE/BIUiu
         Sglg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349936; x=1777954736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1kHYMN2hdrkh8km3xuB3DZPgiACrDlk18Lyz165PNqs=;
        b=JNzd5u24km3bWHK6BmP3my/BFsSijvqqPBGLCKnFCQnJP3DtssTniNz3jG5Q/QSRZJ
         VAGisQA1aUYeVfsWQ2ULpDFY3z8XDGy8RWttieIF1GadsoISpw67Vz/2n6jB8QKaAEv4
         /YZpAUzpBgxWn9zbFz1pn9rZF6ZbTKsjksxeZhDslMh4kZf0rZaMAhs1vluhiaRxaMF9
         NVXIF1Q/2DLN7Go3ssiHO+yMlfsgQFMFi+2uQeuQ0RwrEydq/RVXFuba7VEDF6G9YCwx
         oGQpru51aLnXQ+Uz3B0FA8h66w88NIvSQXkyoVoJwIfb/d1jM18UPuYclDmYHttKa00F
         hyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349936; x=1777954736;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kHYMN2hdrkh8km3xuB3DZPgiACrDlk18Lyz165PNqs=;
        b=mfPy8vVRziUaoNEkgvdNEpLFboGkMTDM6iPh3LbbgPTS0FHMtzo/EDN7t2XsTMhATs
         PTI/OaJdaW5inoQxcMq4pPgMHjxc9XLF3D7uRZw8GBb3+O6/kh/lUjg+m7dgRfpvl52y
         bt2F0qhrDImcfondaCApYpUZHp7L0tgPXPHoXrKGrET+nt9tjzzcdD8DcsgViDHpM7oi
         a7gKOxc9rQgQj7oL7z6OuAyGD42WEjCK9T1nqtNXcbOANz7HVOZS1uuafNmtme+zio6z
         aJRM7J9aZEj8Y5d2Hqqof5jzZKl786UPOKZiYpLOoPUgtVc8NIdWaj+VrrWiP4zISrsI
         t/Jg==
X-Gm-Message-State: AOJu0YxNO6FKl5ia1QmfWgorPMfYaWCw065rut+KOfHRhBjMpM/LQn4J
	zVNq42Jq7gqdB+3vG977CG33kY/UwCmr6gECHv2rGNPlCNWcNfmu0HI+RIxTYUI0Rs4MjeNyuMQ
	AtfX2//1yTU7Gx5Q7XIdjMzX30rYuJs8=
X-Gm-Gg: AeBDietho6AyaUlqOCjHZz8ThYVR2MvLsVcZuKc4kbqmDPlzby7Fis5sqYxuUUbqD/N
	pP0b6k6H45xoHJSZzlMsgEMNH83sOFYyI2VF3VhdNfs9Xk7J7iBuNEXbbdwYcvo5PcJP0NtN81y
	sGOBMxMgUzJp7QRx6bZfTPFphymhpHgrplb4Aca52glwTF0LFShQG86B6pETmBBsmfilnABDNtk
	vojcUocg7pRWU6o8Z2izKc35ovv3gl5VB8yoBTvvG9al2MYgL7uIOpr9PkkoBJgDGM484vnVBk1
	zBdRYlPNCaar7bXSvYOB
X-Received: by 2002:a05:690c:a01c:b0:7b4:b591:e77f with SMTP id
 00721157ae682-7bcf558d887mr10349877b3.32.1777349935652; Mon, 27 Apr 2026
 21:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Tue, 28 Apr 2026 12:18:46 +0800
X-Gm-Features: AVHnY4LK5k7_yeoTcHWaYdG0jtTJFEEtWGGZjLrgR1V3Qv7wDtplfZgEtsigmis
Message-ID: <CAGp+u1aFTivN-EC5QQaQ=j21GaGHktunHEzWQ9e2uASsE40svQ@mail.gmail.com>
Subject: [bug report] Potential order bug in 'drivers/input/misc',
 particularly 'ati_remote2.c', 'cm109.c', 'keyspan_remote.c'
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers,

My research-based static analyzer found a potential order bug within
the ' drivers/input/misc' subsystem. I will use the potential bug
found in 'drivers/input/misc/ati_remote2.c' as the typical example.
The similar potential bug patterns are also observed in 'cm109.c' and
'keyspan_remote.c'.

Kernel version: long-term kernel v6.18.9

Potential issue:
T0:
ati_remote2_disconnect
    --> ar2 = usb_get_intfdata(interface);
    --> usb_set_intfdata(interface, NULL);
    --> input_unregister_device(ar2->idev);
    --> usb_driver_release_interface(&ati_remote2_driver, ar2->intf[1]);
    --> kfree(ar2)

T1:
ati_remote2_store_channel_mask (registered as the device attribute
function and exposed via the sysfs)
    --> struct ati_remote2 *ar2 = usb_get_intfdata(intf);
    --> ar2->mode_mask = mask;

In T0, the interface is nullified before its get deregistered. Thus,
it is possible for T1 to still get the usb dev and access it via the
interface, which, however, has been already nullified or even freed.
This similar pattern is also observed in 'cm109_usb_disconnect()' of
file 'cm109.c' and 'keyspan_disconnect()' of file 'keyspan_remote.c'.

Thank you for your time and consideration.

Sincerely,
Ginger
