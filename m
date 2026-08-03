Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF851F30BB;
	Mon,  3 Aug 2026 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784673; cv=none; b=bzJb0BytgAnTo+IK1OtAcyBCUx3hJr14pMBFbg3nIg5ahg03hYTbtcKVgtWRjM22lB85NB25l+sb39+qdslONHGorXtOZ+fqTqVDPTRsc6erzrfJmB7julNqnW6sM4dApfwb8kpXzL94qs1JAigYj8tEcT2WKnTkO9i/8AEJx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784673; c=relaxed/simple;
	bh=p+CPdroeJdxuqSM3gWoBugWTGatyWV5tc1O/VxnbDTg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q9bvZ5KzA06ZBH01Nid2Kalr9V3lxTyb1uRIEz2/IzPZWZ2EdAGDSpp+9Kf6YS6JIB5d2nuCRvzPfDnZo03pJXnfsz/GHGsmaeutlG3FYM1tiRHquDPlNcRLEM1wI8wFWRh87iPfuSYWsSiJz9paiG+NTzystD/0ViIGbI7Im2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrdeGAN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrdeGAN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBAB1F000E9;
	Mon,  3 Aug 2026 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784672;
	bh=anG6O2DrggrASDFbBwtjm3HDD9a7QD7aOWSsnY0ODNk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GrdeGAN4MINmV5lZFRWEiDyQ/XSXbYInyU5w6b4ySUIZ880BCbROmS+IKpxxQXR0L
	 aI1lJx669MFQ0kemR4ByHbU2n8XXvryHQdHqOkIK4w65hMhkSrJxS//nf/F1PlQrLr
	 JGdx4lbCiSWbeJs6Ft848N5XnJ1oZ+yY4WbqqrfyMdCXcOyeBk22MZm+Ii7SZnj4WK
	 ii41/xdCFoKXIH1SyrN0/I9XbxKcD7FT+QvLbXUBE1WwEJjx2bp9c4Ee1e9C46e7he
	 bs8ZModDYkVu6erF8aNdqVHSGAtCHoa+TQIZGXJo0JPu/O4cTSHP2jllINhoxJEk8v
	 F9j2oSp0iho8w==
Date: Mon, 3 Aug 2026 21:17:49 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
    Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
    Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] HID: asus: support the Zenbook A16 (UX3607OA) keyboard
In-Reply-To: <20260724-topic-asus_keyboard-v1-1-a746ff8f77b2@oss.qualcomm.com>
Message-ID: <5po665s4-3909-o34q-r310-84r2popq522s@xreary.bet>
References: <20260724-topic-asus_keyboard-v1-1-a746ff8f77b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jul 2026, Konrad Dybcio wrote:

> The ASUS Zenbook A16 (UX3607OA), a Qualcomm Snapdragon X2 Elite Extreme
> (Glymur)-based laptop, carries its main keyboard on an I2C-HID device
> with the ID 0B05:4B42. Its Fn/media hotkeys are emitted as vendor-page
> (HID_UP_ASUSVENDOR) usages on report 0x5A.
> 
> Match the device in hid-asus with the standard I2C keyboard quirks and
> add the three usage mappings observed on the hardware:
> 
>   0x85 -> KEY_CAMERA  (Fn+F11, camera toggle)
>   0x86 -> KEY_PROG1   (Fn+F12, MyASUS key)
>   0x5f -> KEY_PROG2   (extra programmable key)
> 
> The camera-toggle key reports its usage (0x85) together with a companion
> state byte in the same array report ("5a 85 01" / "5a 85 10"). The 0x10
> companion aliases the brightness-down vendor usage and spuriously dims
> the panel, so add QUIRK_FILTER_CAMERA_COMPANION to zero the companion
> slots for this device before input mapping. The quirk is device-gated so
> no other ASUS model is affected.
> 
> Assisted-by: Claude Code:claude-opus-4-8
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

