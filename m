Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A83C8716;
	Wed, 22 Jul 2026 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764180; cv=none; b=Xl2SbQONgIpOm7GrcA3/cvAJgP4PuwPeQKjFcIS7EXNEguwMpe8quAdlivPW9d0Bj1+bgQdJxFPNHWaSRxy/YzbSPGVE9ljaRPUa3JVx8XaUq1wdQi/P6Ty3YwAG/0xr0M7eczi4+pjA4v62OAKLPamd7fH/8u2NCaGWgP+wlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764180; c=relaxed/simple;
	bh=tBYql9nw/n4XMjDIzqts75c2dOFiCNvLQOGw04kgQ/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JVwVB7m+M8ZyIei28lz/0gMJoYB1lWE5GbqAEPi8Bbf4/Bc8QxQ9wwKxP6QGv38Vs4uKoDklDJeOytuW+q9QHpNgsjVRmKII2TQVsshh38KRfmxh7rrViK+CTaia64m9d18mWZZU2BFEaM4psyOitPEkvDt7FG2eNRGzArS37KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg4XrYV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg4XrYV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9D41F000E9;
	Wed, 22 Jul 2026 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764179;
	bh=bl0hvo/WGdSWSCI7skRFIfDfqVMWzJ9d2SiDKk+uPLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qg4XrYV1rkCQEHifMSue2C0O/vBd5CIrO2Ixz1RCil6AGbqwqmW4aC/FMqkhJw5vV
	 0uRgacdYObR98bXb+Tlbw6atlZenIdm3I3mUjUvv63m7suvLit1HV7SzMySWAjzoZl
	 rpY3sc/95l17coQYoAKK4GvSyEvAETsptQTke5vHdmgEbB1OBseY0O0Mb9ZVdM+QX7
	 1BU8noqyDQc2izcLZoGoe7KYJqtTEGzqbkJbbh1VxS9vF3S++ZYbv5zN/Q87dqnkdy
	 iw9zQoSs0curKmIuZin4AH6AYc+6DZGaUABpI5mBfvKWPhbrHjuujKgDcaS1ebfA0t
	 FQBFuD2P720iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags
 match the struct_ops set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260722233518.778854-7-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:49:38 +0000
Message-Id: <20260722234938.DF9D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU NULL pointer dereference in `dispatch_hid_bpf_device_event`=
 during dynamic HID-BPF attachment.
--

--- Patch [6]: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags m=
atch the struct_ops set ---
Note: The format of this review is altered to provide a free-form summary
due to text recitation restrictions. No direct patch diff quoting is used.

commit 460380780bad5817b193c7927dc05e04ce9f5480
Author: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: HID: bpf: Make syscall kfunc flags match the struct_ops set

This commit updates the kfunc flags for hid_bpf_syscall_kfunc_ids to match
the hid_bpf_kfunc_ids set by adding the KF_SLEEPABLE flag. This ensures
per-kfunc flag consistency across BTF ID sets at build time.

[Severity: High]
This isn't a regression introduced by this patch, but while reviewing the
HID-BPF event dispatching code, a potential time-of-check to time-of-use
issue was noticed in drivers/hid/bpf/hid_bpf_dispatch.c.

Could this sequence lead to a null pointer dereference when a HID-BPF
program is concurrently attached while a device is flooded with input
reports?

In dispatch_hid_bpf_device_event(), the first lockless read of the device
data happens during context initialization:

    .data =3D hdev->bpf.device_data,

Shortly after, a second lockless read is used as a guard:

    if (!hdev->bpf.device_data)
        return data;

If __hid_bpf_allocate_data() is concurrently executed during a program
attachment, it updates these pointers without memory barriers or taking the
driver_input_lock:

    *data =3D alloc_data;
    *size =3D alloc_size;

If the allocation completes exactly between the two reads in
dispatch_hid_bpf_device_event(), the first read could evaluate to null
while the second read sees the newly allocated pointer and evaluates to
true. This would allow the code to bypass the guard and execute
memset(ctx_kern.data, 0, hdev->bpf.allocated_data) with a null pointer.

Would it be beneficial to use READ_ONCE() or proper synchronization here to
ensure consistent evaluation of the device data pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233518.7788=
54-1-ihor.solodrai@linux.dev?part=3D6
