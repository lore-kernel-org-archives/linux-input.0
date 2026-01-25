Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994E3112D3
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769320292; cv=none; b=GK7p38GbmeV97rjd/o6uyhWCU3RB6SPbNIqt8GS1iut0kSf4JZjoVPAAQ0W0y/EFlxXu1ZrAhERYbGLqbESBxezgrB02TJhi/3aKn6UDT6DuBiVW2Vc9fKZuDBm+B/UDh2HonvQabB7olc8Y33SQFSaGE24XrijYOBoIdbHpyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769320292; c=relaxed/simple;
	bh=0wiVUgKJ3ZpTnxIJNGPp+d3uPOmuBOfChoPCQkwmsSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRCP8gB3PMEbJcg3DiNg15GUxYldTCP+vjov+BerZ7CJDfn58PUvshVdvylosuADioyiB574pGu1yghZoNqs6L5ZG0gFXylzWeduvXvE1OrYZMXsr5R6kVBJcRrmcTRgzaLOoxkF74i6yNzrhBfC2QSGqXUh7LlfLqQOdaWlASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD9/Nymj; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD9/Nymj"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b740872a01so4404821eec.1
        for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 21:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769320291; x=1769925091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoAawfiIr/ITCwu6u8MF3r1AnjqzuCgejwwLX66snfc=;
        b=VD9/NymjUyxvoq0iHH614R8oqTwQ/mGXwi5vkMR47vZ8kfe94RYIeSk+oeumYmnsO3
         ZZYEUE70hhXvl3xN8WsPVzvwHUVsrx113Wp7GPiavb7hJEQ66G6oTjlM5qsj4zk41myE
         iNwVJNPZAfue90g3gnUJZ8fsjrtUvWOmYhNYXuQVTEq9qxYI8z/z3iP3XQoqSu7pY0yx
         oeZmjtGaJcEFCqZ5J7LnqyQOVSKZyubbgXxhkGznSETJ/Ogh9vBlx91BHq3ykvpdg1VI
         TEtidcxblbP2VngC+84tq82QUxjQNkPHRuNwrIA/OOEEBBr9almRV4WMwOOjtZn8v3ln
         7Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769320291; x=1769925091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoAawfiIr/ITCwu6u8MF3r1AnjqzuCgejwwLX66snfc=;
        b=Q+HPs7B+/slY2OtQGNLIsDT7IRTl9ImFgg4I83VFeLUkRuPYDCAsGyAZt5713qj8Ha
         ZwDyC2Zlkemukx2snP1/n4jF+4eJB1b9d9M1QcJ64CMPRxqiQ9wGRfn36X6V7btYBtLs
         WBkbW5YacPAuKMbrt1mli9tU2V2tAAQyx8Vh+XzpN7zIjMb8TQoLEvfNod6nBIggZPKN
         xogfySt/QXwVexbrQPOgOfc0hShkmr9Cy0GcOU4t984fnKRFtweekeQOlCRR3DYwJkM1
         TcVjq8NRnJMok1P79K8x1V0wSKXwBkSK8JejMqOrMuqqGucapItDGuOT5pYm7x9vPMTg
         xyNg==
X-Gm-Message-State: AOJu0YzTU2AE0xmzA52MOd8km/k9pPs1VpqWbdumCOATVmr4Kyf8UMPq
	3xRX6N7FxKY53rSasN8T/dP3zUVy1ehnsc7wSh4J/aDpPdzyJwD+p98d
X-Gm-Gg: AZuq6aK7jnjw+S8Idn1KEAEnhzb/jg6gVCQI0RYnt01rZ1H/SooNFl5fpVxVp0RL60H
	5Z4gP/NIxjHa+1nvEqndlHVXXOsq46wTm5gWtba4AEop1pCCSox23OhV4nY5y/2uy+edQ5ns1Ls
	3a+BkjLfQwUR2fmQylU9lebf0sTm8qMSUCPMGYQPXKVsvshhdsuMYhbFzpxS0ElVZJyepDmGaEu
	8viwTqGJby/b7PgPvL+vIL/oAoLW8O1tsgm2JxCWSfX9GVNBympKW+TPNXM3KaVnG80+ZLCcfXY
	f0asJd//uIgmw5uQ3zhwIjQLKtfSBO+QmlAmy38/DKnNdeG4KS0vhKRYLCHsbWRrMZkiJHKhymE
	SxihlqnfhT2lO2XpbEztK8fViRl0dHPDOFCxq7Yz8FjsQ9vK87hVkNeTxyW1HX/o/GjJF+KTSvE
	r1cQkLH/a46upY9t6dI2A+8GITkB+m6O1eMldDzoI/5vqExKt51pFz
X-Received: by 2002:a05:7300:6da6:b0:2af:cd0a:ef8c with SMTP id 5a478bee46e88-2b76481f709mr383410eec.36.1769320290921;
        Sat, 24 Jan 2026 21:51:30 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:106d:a8a0:84b7:2d62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d10sm9699228eec.15.2026.01.24.21.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 21:51:30 -0800 (PST)
Date: Sat, 24 Jan 2026 21:51:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: feng <alec.jiang@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA
Message-ID: <tiz6ryc7cla3jnhjrv5nymvk2ptlu7u4akiqawt6jp7gc3luvf@uzl4lbwohm2u>
References: <20260122013957.11184-1-alec.jiang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122013957.11184-1-alec.jiang@gmail.com>

On Wed, Jan 21, 2026 at 08:39:57PM -0500, feng wrote:
> The ASUS Zenbook UX425QA_UM425QA fails to initialize the keyboard after a
> cold boot.
> 
> A quirk already exists for "ZenBook UX425", but some Zenbooks report "Zenbook" with a lowercase 'b'.
> Since DMI matching is case-sensitive, the existing quirk is not applied to these "extra special" Zenbooks.
> 
> Testing confirms that this model needs the same quirks as the ZenBook UX425 variants.
> 
> Signed-off-by: feng <alec.jiang@gmail.com>

Applied, thank you.

-- 
Dmitry
