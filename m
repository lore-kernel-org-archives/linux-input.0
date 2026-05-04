Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0D3DEAD6
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914058; cv=none; b=Sp4TIBizjyIxOLS7RLtvZxhPnqvabOxgkY3DzXFeF8kytX1Zvw8A1NQEUbRjymX0GirRJaVbD7HlZsWl5gZCyc8b0YGsqZ8ClrIj2W+4BpiLL2akMHoiknoah3FkZzWiH3JxO6KkO5memdU1clVJzEAvMPD970qJCQ/9Gq40Ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914058; c=relaxed/simple;
	bh=SvYuwhoj+MC168s8WF3aTNPzHTkFNFVNcEfomso5Z2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhTIRl9Ybwy0MzlPIl2TUGukzhwKdqUJOGXRnIyuOBzRp36GvUxQs6H+jr2Yy287bdqQwrtYA9Yu3/t6+BuR3ZR2KM+EtuD2xRTDwEdwcw6Ym7nHl8R/ZZJ4k1maFQTSxKpHiBSSYJRsZR932RGLfy1ZP4lCkKr+QtWyCJUCKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOKZRrjo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOKZRrjo"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso2221701eec.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914056; x=1778518856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PGmmr1OFx7Ef94Mvp1XVRRtzp0lP2gGW1M3Ai8Oq7U=;
        b=nOKZRrjouj9Z5KU5NC8oAQ4xO2YXGRJr6wh8adt3FXLhtwD53n2iGA3/48Htv/yGyU
         o9cWfA1Jw/qmqseqR6bf1u6rSFulZdehBxtSwTohbTHBgotNoZ1vJTpDaTToi6UQ2T5l
         MawUK0fW8EtfGASyeyigKEeJ/7SAY/KUIWiWq7MKpJl8Uqo7HXKF3Flti0a0kv8JbIh5
         7MhT+d+cEX3MoNdKmdri6jALpFzWe/XWYg1ZuN1sKQZ4skhmAFNNGbb/lrtVqwFBelw+
         WuMkNLrY27C4pnVvAL/XdvMX0A8jkf6oIgTUmEqC6c0Rm6UBuLz5OWdsrZ52QU6pXjri
         kHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914056; x=1778518856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PGmmr1OFx7Ef94Mvp1XVRRtzp0lP2gGW1M3Ai8Oq7U=;
        b=PVVQs3eIsQ6oG7belJfZgTXR5FrHTa0gnHgUNv149Ky0PcBVXZHqeQWgLf/9G7diZV
         ewL8vjdevhCAOwBoweUtpIRmUTHJcY6PLQ/xnb8HUXltBQVAcsY5x2VxOTJSuB+6Z38B
         VZp8rlUJnQoES/1FacY4CMlEHyFXLURrgVGF60BuyzV6zRUc9rg9QKza67Y4IfYFtVt9
         x1LaVCJA0FBV7cLa6ktxgRNLJ/qaQP9CIinqNgtwfdvocCvPsB3bFbbZo1hfNnBJ0mjY
         D8smveCVLtpCwo9sFqE81uukQ93PYZIFiEB90m1Zne3kVpa3QGh17cawKKrLoYklV6C6
         FFLA==
X-Forwarded-Encrypted: i=1; AFNElJ8FkDs1lbMJ4yBsBp5fWLosCSWdQcoa405pyJQvxZ6159+hqfx9FyOaYo7xkXWYCHqByu/tAxpp5yTRgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvmrECkLvxrUjao8TKyT8c4Ownuqv+iFLExO7+2kiJh0kOine
	ioMGVFx1KgLp+CUMpknRCkGrpu6a1mOol0rfPDr946X9LM8lKfTsyHKh
X-Gm-Gg: AeBDieuGQah2ARmhZkqVC2iCl/BESLTCcwLQp6Y5tfaz+EgzvmSk23bjLfWwQrfPxSB
	YBXtbQauZ1o4SyLa8yp31Imq7KPgeruk/xyZRFcOLc9U+WEmDE7X+rhhN3fqnYEBtQCmNxHeBua
	iDOaiR30SJbEiEiTLzwxQt/I4aQp8xTyBZbYKEGRNleDvOYXz/xj/fTQ7fxF7p0gARE3CQi6U/e
	XggwmQhqL8/GmR+oiregcrCj3gP7yo+hLezg/ch8qI0MM88hZOwPP7FOus5EAFz0Wnt+xlKWgN6
	Neb9WRgCaHYEIJgVGpJ22/axX2MdGZKiX5Svyywj20IcQs0ml4lRN277BYa5swberGPDO4/Yowb
	bwOJXkoS9kAhFtTIuQkMzAzS5/T5LsVz+3T0i5op1Sn1P8xp+jOp9RQ7UrQelryPu4EkGPRHqjd
	VQDcSodtX87PrA599N7xlRCQhdiv3ZOPaM4CBPY8+DD8H0CGcwfvbIYAbtd+dJ3zu/GIl01b3aW
	uXW7mBYCpRRzg==
X-Received: by 2002:a05:7300:fb96:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-2efb8aa1d96mr5274059eec.1.1777914055733;
        Mon, 04 May 2026 10:00:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889cf53sm21498060eec.5.2026.05.04.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:00:54 -0700 (PDT)
Date: Mon, 4 May 2026 10:00:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - Set byte_offset as signed
Message-ID: <afjQpR_PyjsSgI9T@google.com>
References: <20260504-fix-sparse-v1-1-1071137cd280@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-fix-sparse-v1-1-1071137cd280@chromium.org>

On Mon, May 04, 2026 at 10:55:03AM +0000, Ricardo Ribalda wrote:
> The calculations done to obtain byte_offset can result into a negative
> number, fix its type.
> 
> This patch fixes the following sparse error:
> 
> drivers/input/touchscreen/atmel_mxt_ts.c:1481:44: warning: unsigned value that used to be signed checked against zero?
> drivers/input/touchscreen/atmel_mxt_ts.c:1479:49: signed value source
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Applied, thank you.

-- 
Dmitry
