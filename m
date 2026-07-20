Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F23090C1
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567243; cv=none; b=lY9UQTlYnaJBQOF47IsV+G810f+3G4COso8zSxYlP5dSje+p65eLY0kNIszM9ISr34KFDrXSgoCoj7ogdc6A/tQmd3TyPkEh35ku7y0dO94ofL8XnzWQGngpx4T1TvfpOalFj4xK0Gz/9WBEtpU1Akuet/vyiO7T/m4PJty5nwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567243; c=relaxed/simple;
	bh=Vw01Z+sL/1hbRFjNJ4D1VTaYqItepSIEaZJri4R0wC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhe78Yt5q5uzRPMNL80FPyxUJNvX7vnC9JVV6XKHIIhi0iEPd8zrB4V1oooLG6X6MPuBoyRCXsKLbXvFl3mIrmTBN2VRq4VBmZSqwKfgiZ+RjjBJF0yx2Ij9durU+78SDHnaeFSvnnRLtwW3eW+gFs0IoItimkargPQ3ckFC3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRs1E6mc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRs1E6mc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacf197759so115632245ad.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567241; x=1785172041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3Y3qPQEpDGTBYNYDJOA+C9hBEdmmPNqXyT4D9qntj0=;
        b=DRs1E6mccB+6qv3GsFZt2nxcDlclKSL70JvNkEbS9nQ9WltNdYY0EU/ctVk0dbTJU2
         6gh2hixOpKogJfP74oVM7Brx18Ok6elqH0v5SQX+3Uan/kvLevVg+N0F5S4BYeAYnUYF
         pNXoKhJs+n+SLw2vL9kaqKY36LSD8kXaEFfMkQtFPzEQm+o/gn+VO9oLAuUI2g3Tf1PM
         Bvd+tqdgxQmBFkf9kip6LxHQVNiWTyKR1CtIh+hi9O3HFWdXxm4higFv7SUQQsTKT1fp
         Q9Xm85k0iDPaeZw/mItSH4x53c4jY7QLnjGBOAkSSmvG8dHWyYJjRO6h/9G+vtumaY9f
         he1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567241; x=1785172041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3Y3qPQEpDGTBYNYDJOA+C9hBEdmmPNqXyT4D9qntj0=;
        b=FvN6uCyLksc+69/xFnOou2bKL2dgvHGZuCzpYkDKNVHAmZNf7Jft3DmBqXmGG7lZjD
         /NtrCONOCeabcT8KT/Rlyex1jF5Y7YDx7JRUs06P6cwMNp9cPIY/AJ9394YbcbD+Nn5X
         gf4y5gvDMvqkocZJe1bkATEUZWpM9BFBx/guf00K2KkDvRFFZm/V/BeHBrmkSyo9ZfhR
         W9vEMQA7KxSCiql/eICYvtl7JBteHi5K9Xbj5YNqJE/Gn1rTuAyeYZJbklCqYWgMlhQq
         P3iY5dUcDJrKlMfu4820iHl113H2cS/ZC66f9xI974V86WnBBMnLzJQPJ4O6J6Dh5IYV
         zafA==
X-Gm-Message-State: AOJu0YzFudHlq+qzP2+QGh6U1ppP4f71D/vBOKREkshgI5JPvoKlqY8R
	bdKK1TfSVorbF4tCHkXwqB8jGJnSfOkmSl3dM0uV6dyWYtPAgFB7w3pA
X-Gm-Gg: AR+sD10gA+Zt6tL7rWcZ4CYlr+tIJPW6ha8vzquShqrPR9YKAoScqLtjtfgScOUDJ1o
	hvQsWdpBOhCwzAo3Pa7RoL5V1CVAncSD8tkzHdsaD5MPja2aL46qUD5HbEWYUmKYg55wOW8t/UP
	JzXwe05Kq1XWetwKKcGVa/E7YiSy9maN7UZ8VLwTMpNY8V9x9q+h/wGtDe7hcrPImvVEBT/KS3I
	50/wN7tpBD/15kSNt224Ckkp98FqWSLqtA2v47kbw16pZM4Cc93zyaYFPHJU3IsUYrTSCeiuUKB
	TFXnmxGJPx/KEY+VDQKjCn82JYwQMmAkp9KFUZKb2GWtF50RiWKhadYjEsaHRsCNE4A9XmalnV/
	+PBgOiWLyE96SfLqKiWB/9Yx90g+AqA2aY0CkHd90IgzHafzn5gjIDwk6KPZH3QHfLIfGtI+OMV
	wApYHVwIgBLHJGkLRmBFfDgsTbqbyDE6vpEP0bhyQxjw==
X-Received: by 2002:a17:902:ebc5:b0:2ce:93a3:c168 with SMTP id d9443c01a7336-2cf3480655dmr165978295ad.7.1784567241424;
        Mon, 20 Jul 2026 10:07:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a068:ecf:2296:fd47])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm38186661eec.24.2026.07.20.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:07:19 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:07:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handling
Message-ID: <al5VY95YC0Y40MJY@google.com>
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090851.230244-1-phucduc.bui@gmail.com>

On Mon, Jul 20, 2026 at 04:08:49PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Use dev_err_probe() for devm_clk_get_optional_enabled() to handle
> deferred probe correctly.

In what way the does existing code handle deferred probe incorrectly?

Thanks.

-- 
Dmitry
