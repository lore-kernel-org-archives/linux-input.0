Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AB36F414
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957171; cv=none; b=Rdp7f6i+gjP9KAPlZ87FWs/az0vnc1pXoN8DzNdwpMB5vpX4aQMZixO0Oy90FJcqtTfkyzMOqO6qmxWXlHMIRi6pqKyjZTmerL/uYh/Lxh4nSd7XorUSdHrAtfW8WioFL1AAToge40zZaLMXdBrGb5uoIdr1re3WLt5T89EY3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957171; c=relaxed/simple;
	bh=OjfTlHP30sayTpbmYqiyqSKJ5L4X/Jv4ca7vmhYPKlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw6QvlTznWlYGL2338W9AncmRevPTI/rEbYFXxvbEvOU5Mj3vlhWsn2weoxZMLgJFGkPCUUFLAhFi0uFZFkP+iRZQ9is/gCvNJP7MjaffpYI1pJxaa+yl7jgp6XmeaqyU1WyVIU/YHlh2dCMFThmQRgBIr9Um4skq23RJ6MH9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbyj/eGY; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbyj/eGY"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651d692e833so6979158d50.3
        for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957166; x=1777561966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrPRGo+qS+qeL6Wzz6luFmnxa6JCnRNWW2bTUTWg+Do=;
        b=Vbyj/eGYxPySXm3oAfoGmfN6kpvNPdqZfx74cPqQnXAQhJP6QhPM28gpgGRNNCkncm
         ET3zKUh6xXN14bkfl1oRA7hK0wpFZ2jK1Jxt8Jq1nkZp5fZboxaEEuu91v8+7Vip6soN
         Fn8nbDgp0UhTONE5W6GKC8o0CwFeAhPWk/kNsEsV5QsXXZaSAayKxsVE54WZfAb3uUwY
         9Eoic51FRYM7RY31X7OiZxIAHBJxKBJHjHIkFq6OUQyIt6UpLiB1XfCVJ0DIS2SWoP0N
         T7Jbx+LubkhWwGMww3nvAxnwjsocPzZJujpCByrYwVXqr0xNZPN6W3lfTr6DbSnM3NNZ
         smVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957166; x=1777561966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrPRGo+qS+qeL6Wzz6luFmnxa6JCnRNWW2bTUTWg+Do=;
        b=CLFmNLb4QoD7YJFpBd6p4qwDBYrr1VyL4IFO7COlW5ksUEYvBJqzcdJKhXM7p3AaXu
         ivhyM7JjTprTNwmwsljvCKgmZ6L1r17WICbzqGiI14RDf16eCniOqR0KwQGsYP9XWUCX
         DO5L4FhUMliUTRePEmzYVwbDMaJvLf8qRoUEOkMMZMdDmZFXviCEtY5BLEtvyxrMBpMi
         980CuV85J4X+/VvRCp636foi31rnAfgVVlJ6QggDeD5u6TRdwgNfb17EYSeskxd4DHNu
         pDiKiFEx8ozRAPzmcLpUDK7XMtkQzJSkGt33rRyjDNySeh5OiJsIRmmyICB5wjI3842k
         ie+g==
X-Forwarded-Encrypted: i=1; AFNElJ/2gTqPxzLL5YTxUs9Yjd4P8/CoEY9AMDFpPaaHm2/dJsw502QSyBcGGbeH/PzOK18FMfdl/f1o47ROEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vUtOWzte7Jh2rCDyIq2Uly9IiP0Ls+LTObxJx9ng0lFaMGgZ
	HpVlj4Exx8R8g2eYP07wpg5rGkPfOpOqcAPoAY21n7YIsiLpoFdv/jGw
X-Gm-Gg: AeBDieuYJL5aRw55soc97oGcEt06FIb13q8KMOVMZeji9MkncdL2eGtUz2Gm8AYFCba
	b1bZ4nkfbOvGHx9IGTXMXZnCLsFKqzy/N2YUswATC3dStTH7BtGKn77fOoXD+rkTCtVn6FWoNPC
	cA6UUll91xca3bn5NkWOSOE31Pzkea25wx/p+br3JdDaIfD3gT/axciVCSF3QuwJWG0PZla6CMm
	f5Vpl2nCUFP+uuYOMIwIK6ZyuXcUduX7oYyM/jOPhKic2AdL77ORudqKmz8K7cPlW1HC32jxB7j
	+pDYNG7BVFsqZr2+N1v3E+WNs5MsQLCNcVzlSiWjPsY+z6DVMdzIFwdzhfkoyeWIkwkXXa5vWtB
	67Zrj/yef1EKm8T47ngC7FRIkjdTt6N83gCt2rR8IWWWw7xVwzSxLOzgDv31BnmDGSMytI6199x
	ep5UwxbcwgWIwBbNmlZ8TxAjoPNJwKxcPs63Ic1kQ=
X-Received: by 2002:a05:690e:244a:b0:651:b741:8fc with SMTP id 956f58d0204a3-65310a29b69mr18561124d50.36.1776957165961;
        Thu, 23 Apr 2026 08:12:45 -0700 (PDT)
Received: from localhost ([172.216.252.33])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65441e82f54sm3532337d50.14.2026.04.23.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:12:45 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:12:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Message-ID: <aeo25zL_XIoFZ7uK@stanley.mountain>
References: <aenFyk36rTnrD9s3@stanley.mountain>
 <7e6c43e6-7896-4504-bc13-5f12025596b1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6c43e6-7896-4504-bc13-5f12025596b1@app.fastmail.com>

On Thu, Apr 23, 2026 at 10:51:10AM -0400, Mark Pearson wrote:
> Hi Dan,
> 
> On Thu, Apr 23, 2026, at 3:10 AM, Dan Carpenter wrote:
> >  		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected len = %u, 
> > actual = %u\n",
> >  			     read_len, actual_read_len);
> > -		return ret;
> > +		return ret ?: -EINVAL;
> >  	}
> > 
> >  	input_rep_type = FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE, reset_response);
> > -- 
> > 2.53.0
> 
> I think this would be throwing away other possible different return values from thc_tic_pio_read?
> You'd be losing the -EINTR,-EBUSY, -ETIMEDOUT conditions that might be useful to the upper layers.
> 
> Should that block be split into two separate error conditions?

It doesn't throw away any error codes.  Writing "return ret ?: -EINVAL;"
is a short hand for "return ret ? ret : -EINVAL;".

regards,
dan carpenter

