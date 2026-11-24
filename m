Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544383;
	b=cghUS0sMkEEhzwloi+eDN9WwHHcmaVZNekVWextMddssc3bpm5pH0b5JFLDyJOR4Z0Ca
	 NuMat1vP3t3x+tCNwwPDwDfyAedjgPt60OA3l/O3aBq0sYCSmFv9Clr2OllhqpnDvdiPo
	 STCqmiDDbXFlPiMQ8zj+pbyjjJGPrUYgQ2zUYQtLsUiIcgCWqNQsSx7Q8xFxG9OEbThaT
	 indhGU/XA7IfdrMHRz3ym5IzyPbudEQ797oJBZcnSDdeAp5o9rzuwMqF96RAi671uL0hb
	 Y4NdIz5aiSpYxt2CCmBxvvPHZiAMWP3FmCq35f8rPjAesA9shO6cdY8wm10O8iLk43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9akaBTfF6wDI9oHwKMXEjnbhxpjEIU4hGAF8pqsrUb0=;
	b=200z95n8+l8Wu8peFG0grO1qzEfG1Tc11OrK1H/WO1XFuBdF+dUQBzouR8h0+UqEB1jG
	 QRW3UqkXf3cnMN2eDmi49c7WrTVWXdRLgg3bmmkoCK0at/JKvdtaNTdSvFjeePgXiCVgH
	 iDvkrAdappd7rqqyHXCJOKh0bLVQ5rcJP0YdcQCbfKCrsfB79U2U0h1fuw/LwZ7gy1/FY
	 jczaKdODO3XoJ1yh+fQde2I2ZA176dDWk5v/XrtRfQitSLgRbxGTUsGkBwNHlujEzYCeg
	 j8zM5rrl5b3Qi7j/iWE/oZ+i0vurfhA3K28H62H9uIUG8A0jmu++NSodR3j+wHORJ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wY7ezL7Z;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6934606A68F
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 18:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6934606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wY7ezL7Z
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b244fb7fffso4628418c88.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795544380; x=1796149180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9akaBTfF6wDI9oHwKMXEjnbhxpjEIU4hGAF8pqsrUb0=;
        b=wY7ezL7ZJHSy88yNX5eWm11tPgbR57oSI8+P+lsVZYh+5Mlo0A26pskKG4s36ZD+UN
         p4fImx6DwC1Zrs5SpEhwQ+snEAbkWiB1ytpte51ijioXfMV5XuMM96UDXyHo45cTBNPu
         aI3G3gMKo/DwMj+J1G3saAvoesUq59uZYN/AosPraqswPu/5/CF92kAfeFkAhJtwc9nx
         wHSfflEMWq49wGrOoAPyRtSaJEQI9/R2zUkiQV4Bt6F9Dbv2yanx3Z8GCqX6oRoWnVK+
         NaNp1du21foNoqRlBYQDLV9FRL8zsB9/6NCuMi6Rin6NCEnljWT8+KPxvKci0TZOIcmh
         rEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544380; x=1796149180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9akaBTfF6wDI9oHwKMXEjnbhxpjEIU4hGAF8pqsrUb0=;
        b=duI0t6p04gG/ZBmiLXQ4uZ7dGzzeIaz4kIPtjVS/+/OPka+ERgL01ZIItWQCMxjCXz
         78JS4WWQNJds6vl7ghUYn+dwNIPpY45m1pIjtu+MC5eSsx2iARXvExIdy1l3dU/Zj2gy
         yU+lXm3Ki27ch3xFsrx6GenQyyxTDtK1HXxhk8NuLvM2m5/NBU0tgaZ6UBVm0pV9vcQ5
         jZ6m3i5ALkd/YobbxhaRmqRUELQzmUl0ZuWPXJE6Pjc/ah4U8cyhYz+PBhEIEFYcoCRt
         Sm6fJrSU0vCmkMW0pkHJe0rMkByv3B/FIRE83XftxF3NRBGMDzXcGzPi3PxgStF39WJU
         psYA==
X-Gm-Message-State: APuU4Z8ggJOli3AwdsvH9yYNI4iinZTggaX3beGJuTa+6NMLOm57c77K
	irX5JBxU99Is3QLNXegrQQzsfG0qcF3y/0vP4dq2s6kEfAg5jZhzWqQl
X-Gm-Gg: AZFdTZdeEWqTQ/JzZdGIqbhOAdWwRlBR0xF0mFTdzcLpBvqskFJTXsRRkFXQBuD3PlM
	xxoOlkr9Ev3zzihIjzQhkmKbldf8TQELAI0UhQoR5umnUYMPkRRV9MDILDuRK8rnNGxMtQpMIBE
	eok/XAGEXknU5u6MBjypmFWfyQCNkiFjcXHz2W+5RPB2dxd20I/zI/46fh2QE+RmUMsHIPEQuE/
	6DRXhtzY+aCfWyf8xKf4rR9iwqSDIJm0aEDN/KBH1H2s1VBVeW81DE4U44eMM+2uHlZHStXo7S9
	IxP0oZWopyklvOwoOnesgOe0S903+uU63xKQ/Dh+lRS613FQki72xvIZCYdVC2FbJRSWzj5+Uqg
	FfsOE1wr8f9HU6OpK+jy1lEmZCoZ1ZAY3vLTgtOGgcMlxt7+Ebk2Kg2+nRw5dj3zsl7lZdL9Z9N
	UC0dSYB4A8qnC3aVHuH6AH1ocOspRgkAP77/oa5fHodhoqghYmf9XwTjrR36KF0aivL368nZnM3
	k7w7PejLfU/ooMIXSqBRvHYdqn6aIfxZrEQtKYpf0mijfmLYZvskyZQqUgPcbxPAAAwcXNhy7fH
	2fDJrNQpo7S4DYb3IwkTYTlUTT6Q6N8PmJdO38uIVo4evF5pvXcMDaFOYXh/UDLJgVi8EGo=
X-Received: by 2002:a05:7023:e41:10b0:1b5:43f6:74ee with SMTP id a92af1059eb24-1b5567c1250mr13792658c88.1.1795544379818;
        Tue, 24 Nov 2026 10:19:39 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm59688327c88.9.2026.11.24.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:19:37 -0800 (PST)
Date: Tue, 24 Nov 2026 10:19:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: amimouse - Fix the buttons
Message-ID: <awXVMoykw0uYsIsO@google.com>
References: <20261124100604.2380938-1-daniel@0x0f.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124100604.2380938-1-daniel@0x0f.com>

On Tue, Nov 24, 2026 at 07:06:04PM +0900, Daniel Palmer wrote:
> On the Amiga the left button is connected to CIAAPRA bit 6 (/FIR0)
> and the middle and right ones are POTINP (called potgor in the code)
> bits 8 (DATLX) and 10 (DATLY), all of these are active low according
> to the "Amiga Hardware Reference Manual (3rd edition)":
> 
> In chapter 8, "Interface Hardware": under "Mouse Buttons" a 0 in CIAAPRA
> bit 6 means "switch closed", and under "Digital I/O on the Controller
> Port" reading POTINP "will produce a 0 if the button is pressed, a 1 if
> it is not".
> 
> Invert the bits from the registers so the state of the buttons is
> correct.
> 
> Tested with Quake on a real Amiga 4000.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Applied, thank you.

-- 
Dmitry
