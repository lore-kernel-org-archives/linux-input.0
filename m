Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E231690A
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818599; cv=none; b=K52byIC3dfBpfDqxa2vUvap/WWIE8/4Hpvqb0D02deCdXEljFXsQec81YbfSmiCrP2SIgm/62R06gAP7TAOMW3VPO2p/SbpTp/h1TuuoILazwtKSgW6vEAfBipfEx7kg4F/YvlBhln7qUNNjybdZQjuADWK7Eh+mIBw5A1XcbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818599; c=relaxed/simple;
	bh=DH3MlKBo8OepM5KCx3hb0qCHe0GY1i5bgyS+qzKnpUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnpNkoPXXwUqAHgL/ntLH6pBGBQ6wsrd84FADRD41CumRYNykSctcyUelZw15//N12skY8orXqE8cUnjVRbbqAeQrqxl5gdGGie3M2J+4v0OUTAnqwo1GVSR2WrXKt3QjR8bAGvgQW5jEP61LvblirEDzCUVWhd9SLLQ0IKb2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhBdKzVb; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhBdKzVb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso6261297eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 19:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818597; x=1772423397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPs2RWVwVls5m0dIdxfZah4HJgj117r2pISP+fJO5+A=;
        b=XhBdKzVb8RfZNb4ISWxOPndA1hvC2IEPnT3X0kDIzcn1CGyKk/mR9I8rN90dgGfDgK
         ANPfavnebyw5xkspTcHJPYw69Eiq8YGGFwJe6oZ98C4ve1xAcJN9eqc/q6iYsOmh6ZZm
         /kEDjMRwkq/v9NuROB++sEItNga5+zE9IOxxIELosSsohicaGR2c5DwTMfapYdcX3Npl
         qwgq1C8gWqV7Yrgn5uOQI1mDYfM/tF45OxOOz+s4v5Gtm7HOvwDwAvuFHDUV+MKhrosE
         oepTUlNwJko1SuCky52k5D9Hgs2ESJYsp8ensiTyR5QVGYRbX1sM4sVygaTraYkm+fXt
         B50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818597; x=1772423397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPs2RWVwVls5m0dIdxfZah4HJgj117r2pISP+fJO5+A=;
        b=vTUArfMqREVLVv/W2o2DJGobLgFGk+33Q3WVYtFeB9ux/AbvXKIN+RgiR3c82WRRE+
         naJVHUSERCtF5gAYe9AuMHPqoGagESMBfjYaPFvkeZqIJ1seacnyydf2kDVQOWKXUsYs
         HP1WyF14EW3DlCJ4htX/5q4oHA2YP3inVdtJYRgKMznN3uAy4Bs4KA+b3tmJRLsdNEiV
         c8mR5gIFCLufaflQFP6pbomDjkYtt3rBCbXJ6VXZa1NnRIPkkZ3oxulI8ZLqVdXD/ESk
         V79RTcL9THVuiZfWlT0/tcKhwtDCcx9YR/ei3VgQVB6pafKu4sWG3kEf4MQwl69zYpI0
         5zmw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNRr5iuO48c1wDdIh6eHkbvednzsJ2ablT50pH7+6gHA3XmbrnTcxBAO3iaIqL2UoPo1IjuFLs7GhgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIn1/uepc+ZyxR0zRSetqyRJk4beCO4RiA7mS9ReO2sL+qA2ji
	t0e3tBcmejlzvqEpTJ2WTa1jntr19SHhQgdKWhWD2noEs9nzc7qmtkg0
X-Gm-Gg: ATEYQzw8q4bozxBJL9lyR4fZ3ltOj/fuwdbSTEReB0BfxFyy4ueIT1ZMenXEm/kT2J9
	DbiCpdOlH0kh+uPgZ7k17myaLvtTb/RmsS8z+Hif6hA2kd+roD+UQpGmPMN8iXMr5diwCkm034v
	T7fGgDDoLMc3pjtcH2u1h1q/71rqRGosNRBQ41eGoFwVvwjssbrSxGxO6SE3YPSoFkB2nAvTDNd
	H2F6gK3lukf+SlrvMhKr7ETh7lK6Yzoc/7t2B+sEyRmxFuwNnJg7oUrEnm0kQYb2quAGls0yHz9
	76F47AVGdZi5gG0LZ3kCQzi8gkvqCRoz8Gv8QRZi1vvzwlnOIA2bVw4YiNCeEkB5Fof5WehD5p7
	p6pg1fy/5MKOVl2AiFJg9DgpBDZHxqyanQ5Jy0ZtP1eeiHxrA3gFAQQXDpe4IHecRUjdo1Ggti9
	nVqAhFTVzRzr33yAJt2lJTH32scAElnAH53YkVypKdj+Bpu/7MeXNkWOcSy/BneVA=
X-Received: by 2002:a05:7300:2327:b0:2ba:7dfa:c81c with SMTP id 5a478bee46e88-2bd7bd3b0femr3958909eec.30.1771818597325;
        Sun, 22 Feb 2026 19:49:57 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa3d77sm4068344eec.13.2026.02.22.19.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:49:57 -0800 (PST)
Date: Sun, 22 Feb 2026 19:49:54 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] Input: cros_ec_keyb - simplify cros_ec_keyb_work()
Message-ID: <aZvOVKUkPBinrSvm@google.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-5-dmitry.torokhov@gmail.com>
 <aZre0qH8rMcSJsa6@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZre0qH8rMcSJsa6@tzungbi-laptop>

On Sun, Feb 22, 2026 at 06:47:46PM +0800, Tzung-Bi Shih wrote:
> On Sat, Feb 21, 2026 at 04:37:13PM -0800, Dmitry Torokhov wrote:
> > @@ -376,12 +378,10 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> >  		pm_wakeup_event(ckdev->dev, 0);
> >  
> >  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
> 
> This can also be simplified: `event_data->event_type`.

Indeed, will update.

Thanks.

-- 
Dmitry
