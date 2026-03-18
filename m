Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195C35CB68
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773812638; cv=none; b=Tf+ZPz3bLsjd8pF80YNRDySlUru8rXFRCyx3hav2v9caAIzs2kYnhzsq5ztmdttP4DWg7a1HMezxPiNtx+8NSneXrt3N2umI/HVAidkUaOnIHfOXgbtt2+qif5NbZkM32PBK7zY+ojYfJmtzkBw7tA0dXXMxcXrSwUCWH48f2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773812638; c=relaxed/simple;
	bh=CXRBvalcT81w/ixpe/yNM9i+ibJxfbY5qwzKyFWXZpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwLWMSPIYXeXgK1ePVgB9vlfL8HXLdsgJPaeevCKwRt0O08xajZr7TedmyAfDBqnaeSZhVstKcdbylNifTa407tY4X+9Zh3DrZstQJUeBk5miR7E8NgB0dRzl5kXcOYF2qDp/u5v8kh2xbZc3cTeJXb9Nt2lAseK9AYEQFZ74ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/w223m2; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/w223m2"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4b77adso7861017c88.1
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 22:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773812637; x=1774417437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AqHQpUZ1gJiIMiWqrq/dfIimRVU3WpV6voI1z6tR3r0=;
        b=R/w223m2U3KHXuVBZ1IQGaahPrCiZ1HKZMjnbhtoT52UC18/aQ/0d7O8SQCy69uM22
         9Y1u/4cPEfBFJO4vv1leo09ZlB2+hs65UNyIYbIeq2ToY0lmgoagxOQ89JP0Zp8jJTRp
         msoCHBnx/ToQTK6kHFIr5D+ZZaN+3LWsPeenPrIw6EAV6M8Ww+1xuvt9U8jXClq7sRpW
         19U+zBOQ1NiX4ukzmA1SVEcY1bPK8aprG4MMqbVXmMa4wZTBXDBlNy8md39Goz/K8chy
         P3sWJKsbyc+TjmkjONnz+v84ri3odBeopMtp36Np3g4s0TqHsgh0Kvr/sdpJzuBECLYE
         6R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773812637; x=1774417437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqHQpUZ1gJiIMiWqrq/dfIimRVU3WpV6voI1z6tR3r0=;
        b=noFOQSn1La3+6YkpXcbFXUrA09VMJ0DLXh2kzjoA1S+ItfVI5cVZkLf8XkbYIyZarl
         KM0U3GEk2/SfQ8ApBlm/fKcx/Tg+2cPuT26/+MYILBJjFRP7NisZEkoXZT00a93PTnQk
         4iJSWwUxOs7JmSR3V4viOETTqgM/zmEUueGdYj0QOJYDLX+va+XBzBVxuI+9Vy2QFSlZ
         7yZYMVbsHZhubd0hNM9xCSK02NaCDjX019Wywp6qyU91H3QIot5gwixiPe4E31aYYGdk
         Md32dK/5tD+i9Ec75q4jS3wobGJRISnqetjHcjb4gj+oZbPPFLmnZjXXPBxXo18EnrR/
         QEkg==
X-Gm-Message-State: AOJu0YwRKYZ7pRGGhN96wTD6z3mwh9AFm3cpkYrEjC7fI3CKxlO0RUw9
	oIIv6T24urdMvY2CLf1eXAEve87Yx1dOagRT/Oo2rCNZS9elFkLFD5Zd
X-Gm-Gg: ATEYQzyhRcEnikkYrGKiPLZfQVqCoAA+mws1J/ew3rg16F4JEn883nJXjD8PRXaXwA+
	0m2BlOSIC7f+Kt6finq3RvhWU2EC+mtwGK2Sk7bRwFU921wxT1J7h6G+O6EqMC8iASmCchxceqj
	DNAC/+IJ5zte4JEEU4XSUn94z86V2/XV7/tKYbxhzzu6a3nbbjL6QhUh3PZuVOkTuPfqQn9noHh
	Hl5DXMglRZIR0vr+LYS/cu3M0KmrQ6X/DxI/QKtaLj8WApToqJ3QBnYds+yZdk5Vj4FpYsAWtvG
	xiaVM3jnkiKgvxWSCy6OU86qCxAefsfnPNV2IovFAYLT19a5/pemAaJWN6YHSJUpj+HMRu1ccHm
	nE6jgZ7/uwID5pJjvlin20wkjDkjVWOW4cKSkSg4Elu8rMnXdR2OIrFiL5Z/wMeqYx/LwqhuiOg
	SWwgf28xcTbTPDzMDnjyGjtAzaJiRMRdUBqtESe3j3ch3Xzmxv8muXoRJxjzpmNESe
X-Received: by 2002:a05:7022:689a:b0:128:ced9:93ef with SMTP id a92af1059eb24-129a7198bdamr1122052c88.39.1773812636454;
        Tue, 17 Mar 2026 22:43:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ed44:64cd:4ba5:bc15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a723f829sm2948716c88.1.2026.03.17.22.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 22:43:55 -0700 (PDT)
Date: Tue, 17 Mar 2026 22:43:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : [PATCH] Input: sentelic: fix comment typo
Message-ID: <abo7FVLq3qUzxkee@google.com>
References: <20260316181200.146681-1-joseph.salisbury@oracle.com>
 <e35b4f27-53c1-41c2-a321-42a34ade9839@oracle.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e35b4f27-53c1-41c2-a321-42a34ade9839@oracle.com>

Hi Joseph,

On Mon, Mar 16, 2026 at 07:48:31PM -0400, Joseph Salisbury wrote:
> 
> 
> On 3/16/26 2:12 PM, Joseph Salisbury wrote:
> > The file contains a spelling error in a source comment (formating).
> > 
> > Typos in comments reduce readability and make text searches less reliable
> > for developers and maintainers.
> > 
> > Replace 'formating' with 'formatting' in the affected comment. This is a
> > comment-only cleanup and does not change behavior.
> > 
> > Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> > ---
> >   drivers/input/mouse/sentelic.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> > index 02cac0e7ad63..9ba3631e3d0f 100644
> > --- a/drivers/input/mouse/sentelic.h
> > +++ b/drivers/input/mouse/sentelic.h
> > @@ -60,7 +60,7 @@
> >   #define	FSP_REG_SN1		(0x41)
> >   #define	FSP_REG_SN2		(0x42)
> > -/* Finger-sensing Pad packet formating related definitions */
> > +/* Finger-sensing Pad packet formatting related definitions */
> >   /* absolute packet type */
> >   #define	FSP_PKT_TYPE_NORMAL	(0x00)
> I inadvertently added Fixes: and Cc: stable tags.  If possible, please
> remove them as they are not appropriate for fixes to misspellings in code
> comments.  If it's not possible to remove them, I can send a v2.
> 

Sorry I did not receive the original patch but even with the typo fixed
this comment needs more work to improve readability.

Thanks.

-- 
Dmitry
