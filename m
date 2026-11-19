Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120517;
	b=1cJbmdXQhzL1PJ4CHldLntj3+dRr619L0tuCFG9RNerwW3EEBQx6crC77FXVISnCok5W
	 rA3/tUXgL57PMYi/yo1ClzATmlVBCQsq3YSUx6cOzR3CV6tRUjWBkSruU/uBJbLYiz/3K
	 2tFM/KbKYb8aehE12c+bBeP9i8QRGOSRtBhL5h1IC8sS5/VsyoByitxFzqoN5pAQMnaZ6
	 hKrfVzRqm3OOFTRUbvmx/X1fQeS6KbjQchUPo5NI3PDNOprjItDGPjq/3ad+F4MJW8p5P
	 2BRPlZLgoqPZN4AdGVDMq1b0MPxYPNL3FzryMBl0UQ0ssvDm5SIX7jSad/5DtxbNFiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120517;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Q69JLJglWaBuJBzyhpD6hbunhVtkLrmr4avhydj3XoM=;
	b=cCaLdTnny37xVMlwtsgeXXz4owB+/LtjEMPk/OTuAd+faj/uUmau4GPx0DAIR2l1Hi8H
	 Ys9PqqV+lW8JsGib6Ttb2Dm28nj5/gYyy3rDZgFxvemyHFzmi2L7V4Fi/xRtXHmPVf2zD
	 foSfi+LT5uKvbaMa3oWtZtq9XpQBsN1htPOb9obQZBPV5Xn3rh9bP8HZ6XoDf7I5gIB5c
	 pgBNq7Dp5fJDkBY06WA4DUWgIEj4AktbkltXCoDKagmeC1qXMkvS4n/FmIFfuKR+clkWN
	 V6Rwo+a1jqT/N0GfFpjDOMU30fH2rDbphFgnQnPKoackw1NoRBNoF7fvYROK7KH67jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQoIfO3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F760A3822
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQoIfO3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61F21F000C0;
	Thu, 19 Nov 2026 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120517;
	bh=Q69JLJglWaBuJBzyhpD6hbunhVtkLrmr4avhydj3XoM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dQoIfO3b3rcZVEqdhQe2f3KcxJSG0J/gatTcrSU78B+oE3Szqpeu2q3mStSqmpfX4
	 ZELP912sv1D/DgpRlLMJv8mFc3nwGNr6RtACeLtFaTQh8GWIN2KjA3uiXm9+px2U8M
	 KgrkQlkAsKlWUDVylTiL1+WcfiQ4dnzlG3rDT4q58RY4e6oxpMahUAXiaS6BOC2TBI
	 ibkZCJCmO7mC5I8W4hJOq03pgLTMMlbzdn7xXEBq/sqJKMQQ3q1Ae12v4oPOJ33Td6
	 HpYETbdpwAOya0hmqLYqp32z7XugA1yX5t51di/XlYs94RYzhtQe0RED64IWlqnSDV
	 s9sut++C/pw8w==
Date: Thu, 19 Nov 2026 21:35:14 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: suppress spurious F23 key events on ThinkPad
 T14s gen6/7 snapdragon
In-Reply-To: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
Message-ID: <6n81o700-np53-5p19-5n0s-048nspr912rr@xreary.bet>
References: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Nov 2026, Hans de Goede wrote:

> The Lenovo ThinkPad T14s gen6/7 snapdragon version I2C-HID keyboard sends
> spurirous F23 key-events when the Fn key is pressed/released. Leading to
> e.g. garbage ESC-sequences in the terminal when doing FN key combos.
> 
> A hwdb entry was added to map these to KEY_UNKNOWN [1], but this also maps
> the F23 part of the left-meta + left-shift + F23 combo send by the co-pilot
> key to KEY_UNKNOWN making that key unusable.
> 
> Add a raw_event filter which removes any 0x72 codes from the 6 scancodes
> reported in the standard HID keyboard boot protocol report, but only when
> the report's modifier byte is not 0x0a to preserve the F23 press event
> when the co-pilot key is pressed.
> 
> Link: https://github.com/systemd/systemd/pull/44733 [1]
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

