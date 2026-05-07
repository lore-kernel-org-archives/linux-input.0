Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169B3E7151
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182510; cv=none; b=eqIxnXcXP4MWLFJ7DOmUq1gT5aT+UARnlHt0OSFw/7L6vUEBRTxs+5feoBDk+DEi3YZExesFzo0C4pPq7wxpCtVeCotyh1ORZTLZ2ah4aWFoyX6aTcF1qbf3yFp3e6lczJSQTSdXmtmwJtmzLD8l4M3rm7Uy7zwMsnMxKWMIBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182510; c=relaxed/simple;
	bh=vBEzLM5XQIak6owDgRqPlizawuZUvMn3OMKkieaRg4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfwZcfh8InyKCLgSB27bCjbOuGNWcTFz16nuM6ecJMMXaKMXs3gbZedEczefRj2UTsJFu/hkIdmw5716G6rJnWPQinosZa/tUpTI1BygXjA8z7BjRyDU9vChDkVUbE/5cNDV3YnXzpMNh4lpYq5vygbxdjkQdSxppu7OTZuUfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKHdNuls; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKHdNuls"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so2242984c88.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778182508; x=1778787308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iA9OC58ducf2eco+haKVtyt3P1Gj+o2XHcKYZwZT0U=;
        b=IKHdNuls/zCu6kBV2zYW+IyFXnmMSGBXttU/XWcSlTQV/evvIMF1CP5VZXJRPp9+g8
         B4gwSmHyItudgnfABrhvASdQRZWqIYFa/CGm2HZZs4Lre9tLyH36W968TdOdly+VOP3o
         WduChU6B4+Cq+oeLod5ECW9GAZZEC6+DeeNvajDI9NJJeqYfXRuGkirwAkUt6/qKNcU6
         25dpK+PCE4aaCg74fymEyMjR+Umg2CktQm88I4klJ9Qd3xeQlMgjO5mD8XI6sKTxEhuZ
         J/26Xvt3fBvjvk6lz4dTQ0iJjkYyjXFeeoYzFm02oU2Ce/uXtlsrXucYRoV2DjsuK7SC
         uoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182508; x=1778787308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iA9OC58ducf2eco+haKVtyt3P1Gj+o2XHcKYZwZT0U=;
        b=MG4BvLOxvF2Ohc7rgmwSM86MCktIr+hVYGNz5zj2exG9GERRUR6TKXJ+zOFSiC2vBp
         I/VXW/Xme5YNm9r8sIT1KQctHPb3WwnVwqTRz5Gob+kWV3d7QpeG0lmBM9LqIezYHtzy
         ajBblFjvg/SSHh+7JTTY4jBAVgVAGHvWucytka2QHCX02FPCtd6VqXqVbOcCV5scR5Fj
         wO/eaM4N36Qy8TMdVf4zXKo1UTO/t51ZaJVOHjaNACaLq0HdsInQ2IoNodoEuGlH4Hf9
         /sR7m8YyTIXLQhzxP6T9ItNpox+SojclJm2b4fgIm2x43rRdfFK9A7CCv0lvpOZ8ex/M
         XyAw==
X-Gm-Message-State: AOJu0YwGSCDJh44MOAJ9/OnVNPW1taNvkgs9WbnPLOJuX2k8I8GUw1g/
	81+4WqwuHSyVMaqCqX/YyAnHogkd58CEWc27xFILS32Vsjcu1altVAGq
X-Gm-Gg: AeBDieu7k22/soJs7vF2/JKSmgIF6jcPDbxG9StM1uzKY3LfM33PipqDzPoJkjXvqG7
	+WNNzCFZFQ1LqV1wUYN5LYAHZWiZcf/bGxCRUKJ2W0Wy2zjAiKvyoyynflOrTzsh4T2OEw8FTqG
	NkgDyAyaEHOW1mFviKHCwqtQQVHnRFyAlJulVrgsHvKSdYw9dx7ezRBiyTXW+TxnDUwr8vk8DhL
	bfCTp5T39ggIMH+QFwnWg9rWV2sqwWa0SNWywAwIk6K9E9bjULN2zCAJxLUiF1/+qd/gPizoZcE
	KDmKnIqVI/C8I7u41Wdg4LXNiFuvaXdaw01nVkubVPKJ21KxV05XRYzg25hSn7LJK1SsRVVDIW3
	0NjLGgrtjRN5iA4xIkOx4eKj4P7wdEVuX6qZ7CY5VY65DEvz9xJZxKvacgnZixZ5o7joakQwDlh
	a+cILUGGnyckDkGDvMBoMWTdrGPXWDBOg8zLv4Av59fe8nF7hkDHvYYT4cYkVXT4iM
X-Received: by 2002:a05:7022:6184:b0:130:ac5d:8f69 with SMTP id a92af1059eb24-1318ea1fdd6mr3734735c88.30.1778182507645;
        Thu, 07 May 2026 12:35:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6a50:9473:7750:56ef])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1326c620538sm400427c88.11.2026.05.07.12.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:35:07 -0700 (PDT)
Date: Thu, 7 May 2026 12:35:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: linux-input@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Mark Featherston <mark@embeddedts.com>, Marek Vasut <marex@nabladev.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
Message-ID: <afzo03UP-shPfNMe@google.com>
References: <afl3WtbabMFNjE24@google.com>
 <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>

Hi Kris,

On Thu, May 07, 2026 at 10:48:57AM -0700, Kris Bahnsen wrote:
> On 5/4/26 9:54 PM, Dmitry Torokhov wrote:
> > The ads7846 driver has two separate filtering functions,
> > ads7846_filter() and ads7846_filter_one(), for the full-duplex and
> > half-duplex SPI paths, respectively.
> > 
> > They can be consolidated by extracting the core filtering logic for a
> > single command into a helper function, ads7846_filter_cmd(), which
> > iterates from l->skip to l->count. The half-duplex setup function is
> > updated to set l->skip = l->count - 1 so that the helper only processes
> > the last sample, preserving the original half-duplex behavior.
> > 
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > Not tested so will appreciate if someone could give it a spin.
> 
> Forgive my ignorance, but I am unsure of the base commit this applies
> to and I'm unable to apply it to current HEAD of linux, linux-next,
> or your input tree.
> 
> I also am not easily able to test this if it doesn't cleanly apply
> to the latest LTS, but will do what I can once I know what other
> patches I would need to pull in to our tree.

I think if you pull 'next' branch of my tree, then the following patches
seem to apply cleanly on 7.0:

c68bc840f06c ("Input: ads7846 - restore half-duplex support")
011bdf9f3a9d ("Input: ads7846 - consolidate coordinate filtering logic")

I hope they also build ;)

c68bc840f06c should appear in linux-next soon too.

Thanks.

-- 
Dmitry
