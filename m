Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911170836
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789345058; cv=none; b=dk89BcHo3jWTzKmRlaPS42+2RY+pS4bWIQzoozlSecVSnuxNR0cXSiIdvAONh5O59OQW6J/j2r5acqNNEykfwGS6edTIXsbKldGbqJ64gPHlaW5G4o0mlbJX+PYWMs6iMGY1voBzbzwF8TMeD7wSfxEd4NWduDKJLwehsQLbIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789345058; c=relaxed/simple;
	bh=ToUGXbXe0dznPZwkdYYL+ujrWOxxx28Gurz6KZ0/iUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG+T5kclHaPrxE9Blj0jQS7yoGyjNmbn8GwqE8cY4hZAIPjL2op9B87TuAHRTZP6bS0n1BwwA5RbkWnvDu/rPuS6YDTWnH/T/Ki9fX69wsEqR/RGbtZPRlP7j9VCMDfQAs91oUB8ehUdV7EPxmxyplhNkibkcOclWsu7pP1Hoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRRbRaVT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRRbRaVT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1512526a91.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789345057; x=1789949857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kIKo4cCMWw2kkhyANUDVgYYj+IlcsbApWlNRIap1r8o=;
        b=eRRbRaVTbvxD5RmQtHLZjJV+FPJsRxAg8SeW85gCKGBtlpdvjR1ToM0TbKBCLF+6OR
         390CQHgCAHOha9m6BTRuyGGUmgFza1k/rR6qaUgHuUoNS7RyNsBahcfyL5Jc2C2Ajrxr
         etKvo3JFHsXTiI4ga/26PG6+cRY1oUQdJqKvxifDcqkncZoiw6mV2lhQbUK3t5fCzWY2
         JFXyFXh4Dy92U3B5Mw1RiusGvylSFHuyBkIiEurlPIpsVXeVOnB5eLWGdE28PwacVeXN
         oDh2puRWmvagTiM1oyANGVj3wR36s/Z4GMrUD3brmisHJ4OpylN4QRWZ+qFpzSjw4cde
         /w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789345057; x=1789949857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIKo4cCMWw2kkhyANUDVgYYj+IlcsbApWlNRIap1r8o=;
        b=sGUs2vz8aLuavZAjxzazBqOzlVFoSdB3heCDQ6aREF3GU43KaMSA7mcuPyDY/9oMz5
         /OZiifs+C8Fv+Mmek3pKFJgp08h+PGU5hahIvfrgO2fXn/kwPTfuMZhm48dw7C4sQ/0M
         tbnNCQdWJDr6gne/knLmDCOSyrdmRaVHY5lfyZFj/JD92O/I0GuWH9Pn2QlDpwRPaAq+
         9vH0IcHPNMdTPL9HOhhgs6rgwxvDz2+XxmuaazFDI3ma3hsx2Svcr9EGhmRfclhT+90D
         R1vHT+qbBRZMudIer23BxSakmlRctl8kMOLmYTCbfXIiBlrngwbmw711/4fHQIXOwJny
         gGyQ==
X-Gm-Message-State: AFuF++kHiB9tAVmEt/H22ta6VL7yMn+6UHfEFR9lE+8s0ooz9q7ljezr
	1F3dlpXozKCVTeP+rOVpboy4C4LviQRIeFLUKGpKg1hYxp6RSzuNTwKyXrxW4A==
X-Gm-Gg: AYBFou1anOzs+qqYvFA+RFikPTdh7V/SRvBHuBkkN4/232hUFhvUiU01fzA3PRS+GC+
	W8xDrZUwsfC2Zxrkxc+zgh9DiK1iYMe5OFi9GPWNBpN5lJhu9OAcb3/yEqqlxlaYoNlC3+H3gUx
	DPrdOjmoztgHpowKlQA3vPfr1XMTq3a+P5aWlqyK4eZ3CMujMgstynz6mAYYhZbRUWdUj6PVUpk
	oc+TWAnS+qO3Ut9a1+189AyA8fE6c6qZwRUOn68sf0ofKwfv+SVb4oRRiUtzgfgVgLlRx3/qYWK
	9G0CPThDCGgZCXwJ2hDDHR47LvmD6z8Ies1blsx0DQgoObO+1i+No9Ns8iIJrg4lpPHwbOoxu/u
	FnN7+hQ7XmPW3/Lu31Oob3GryFRAlucSakUrQDhIUiQLo0Qpua1D2faydFTWgVHD/NbhFOild2E
	giqsk8fFmJbljA24aWAG1AzdKK5J66w3Rt8XmQAQLUl+GCA6ltkwhqF6vtnF5AHBoInh4wvUkYg
	++cbqWLRAAi3aMtsntt1HnfpjXhu2rQqzJoXIxo
X-Received: by 2002:a17:90b:1850:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-39debf548c6mr731924a91.3.1789345056881;
        Sun, 13 Sep 2026 17:17:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm23934228eec.31.2026.09.13.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:17:35 -0700 (PDT)
Date: Sun, 13 Sep 2026 17:17:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: matrix-keymap - reject keycodes above KEY_MAX
Message-ID: <aqc9GAV5y0a3J-o0@google.com>
References: <20260909100739.3107556-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909100739.3107556-1-lilinmao@kylinos.cn>

On Wed, Sep 09, 2026 at 06:07:39PM +0800, Linmao Li wrote:
> matrix_keypad_map_key() validates the row and column of each entry before
> using them to update the keymap. It does not validate the keycode before
> using it as a bit number in input_dev->keybit, which only has KEY_CNT bits.
> A malformed firmware or platform keymap can therefore write past the
> bitmap.
> 
> Reject keycodes above KEY_MAX before updating the keymap or capability
> bitmap.
> 
> Fixes: 77a53fd21870 ("Input: matrix-keypad - add function to build device keymap")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Applied, thank you.

-- 
Dmitry
