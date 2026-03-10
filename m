Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464B318EC7
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167860; cv=none; b=kvkbCE1TWqavm0Zeky/8OPC+XTIV+UWcJV7w2kfhOlQ7TERLka3luH2YBjw1nFEud8sVH2jA0WIJ9wWYnfQjEYx/EXR8p7S97uwHJsyKtiRmZzMBysvuyDFAWL62gMBQ/a3EsGjXfy+6mCMWi4BSe8Wc5KQ06QvIY/cgZGPXBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167860; c=relaxed/simple;
	bh=0Tyi5Z6JfhNx2J5HDr8c/SApKa6+kYshAqOaIqXpdKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onKpAmiSn2JNlC9MF+A9ixXMN1q6XtrSOu7h2CdrNHW1Hm86437QtU5RV+Hj18OovJd1XRNwr9Q5Qm6QcFfvmpoR57yZMf6UQAM91bOIf0u3WjOI0FR5Qm8eiSknoaow8iNcY9pN3cXdigJ9/nUxAkBmScmiAItYQ1ouR1zwCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdK6pCkj; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdK6pCkj"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso8720065eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773167858; x=1773772658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEydtYkjbJ0qWFFzbilGZORGZlN37D01JySG0l90LLg=;
        b=mdK6pCkjLapO6oVF7c0n14UlTfZ/e0pdAiRJhBp4O5S+vWtn648yrkoXO3xDu+b8yG
         4HF+VbhgdFQKQLp/qcdlUcPON9cYUk5xbIv3yyE+iABPig2XOVG24NpHfsAILeBrgxGJ
         PqwViQ9Oi7k1F6bfze3Dfk79W0V8pI7N5dKaSfDAPT7vEOkZ8+XnXd3pPqdWOrT4TfPu
         1OSc8UYLVpY7VRMGMgEq/RrdbUzUmyyj75jrOxiLet8VGEJR0PT/hTNag3BD5TfFnH8L
         NouTMnxCodSN1kZsgBok6Sm8Nt9Ap/gMq/YFzFrE3/Cw38v2pUn+tTm9sjDU29hQeSoQ
         Z5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167858; x=1773772658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEydtYkjbJ0qWFFzbilGZORGZlN37D01JySG0l90LLg=;
        b=qsWajmno8CWTq5j7ep4p/9LcmNqorEmpZuyj3JvUvLOR1kueEktZ1Trn97fMQcKCJa
         1XXgVMmdslTQRDETENYdctzDbfkrIpPMXfkST3t610I239Si2lBXGXMrgZAujBpL11M1
         zpb41QdMJpp2UKRf9LjKQmtDEeVH+KdxvOTF/xFy93pqgTmYo3hwAdHkNZPJVw+JcTcD
         30Mnmn3+m4Pe7+8NKqt3Ec3x0dRJEzBy4ZpsXW4+uCK8Vb1p8eP1PBbGgTidyPCekmRK
         gHOJVjdJR0YY2OfCyXAqyyh4Wv/kEuZlqjh7yIjQAC0R2eU7IQreVCJCtLK9SwtH009b
         rpkw==
X-Forwarded-Encrypted: i=1; AJvYcCVzbiaKegY003v1FAPqhAQLeTghrIBz1v98s7op+4f5U5HizfL26nIRyMrAshD7cQveP/XVlCZXwfIhcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi90E16wN5E+EtzrAKvP2eTclohB74zI0Hj8plZ/JUVxKripk
	wyhJP5bC/v8x39HpjUBN6u22WUpvxwPbtwk7SlFFIV1coKhSzQo7UVq+
X-Gm-Gg: ATEYQzxxlJ+X2XWIUASJqL3DA6HhCT5l4YqodRvnQ6uIT83LQVTDayUL0LDcqFYTTRA
	yH5gCGXxtrs5PwtsGeAmMxKrGOKCMRQOZb5E/J8s1SfTgrx6HOF5LTYfdFIvUCNAa9ZRG3DG+Kf
	+QB3sWtBAluaaICbrjmGMUYtK3qAhwRcDxIyiMWJLrfzRmZ8217zZETqUx/RdvDE0y8oCPc7BHr
	TKQ9nwJY+/Gt1qs7z0J/kivpiVrp1fTeCUD21BQxvSwBX8+juJOQPzaNcgeMuxR4e2ZoZ+CGzDz
	v+j0859zSuAtou+cW37VcePYf2zTwSZS87obNNB0VAO2njYYRStH4gb2ru5zumnHapwpWxdFtY6
	0wgigBkkoXjsKn5p8u06ck+87WMs/Ch8CUpXucksBQ+SzbH6oOo14r/FaPE19q6ATvqthUcq2Ng
	lLXYSvm3+/qAF1CW8FB2/6RCvQKvG72ldRSzbmAAdFa9hLkPN9y6DeK/9DB99im4AX
X-Received: by 2002:a05:7300:2156:b0:2b8:29e2:93e9 with SMTP id 5a478bee46e88-2be4e08fccdmr5761447eec.37.1773167858414;
        Tue, 10 Mar 2026 11:37:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:9:5df8:fa34:6102:3b03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f64dsm14294515eec.27.2026.03.10.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:37:37 -0700 (PDT)
Date: Tue, 10 Mar 2026 18:37:34 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, robin@protonic.nl, andy@kernel.org, 
	geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hvilleneuve@dimonoff.com, mkorpershoek@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, lee@kernel.org, alexander.sverdlin@gmail.com, 
	marek.vasut@gmail.com, akurz@blala.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <abBkk4Ng-_MDHd6t@google.com>
References: <20260305192101.2125660-1-hugo@hugovil.com>
 <20260305192101.2125660-5-hugo@hugovil.com>
 <aari1Y1CPZSYEVj3@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aari1Y1CPZSYEVj3@ashevche-desk.local>

On Fri, Mar 06, 2026 at 04:21:09PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 05, 2026 at 02:20:50PM -0500, Hugo Villeneuve wrote:
> > +static void charlieplex_keypad_poll(struct input_dev *input)
> > +{
> > +	struct charlieplex_keypad *keypad = input_get_drvdata(input);
> 
> > +	int oline;
> 
> Why signed?
> 
> > +	int code;
> > +
> > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> 
> Can be like
> 
> 	code = 0;
> 	for (unsigned int oline = 0; oline < keypad->nlines; oline++) {
> 
> as iterator is not used outside the loop.
> 
> > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> 
> > +		int iline;
> 
> Why signed?

Does it make any difference given practical limits on nlines?

Thanks.

-- 
Dmitry
