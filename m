Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1235F60E
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177385; cv=none; b=BNlvs0IxOQ9eytde6Eb0dj3O1fS8GZcYUxKejg5IKOAhBBWsnpkgMeF2tWA0bBX9hoCmkGziCgQaFhGL7BrhP79HNGINGFUXkPTI/TwQO97nLQCZIbll99oL33l35TUxRBW786OTqi5iR7onqLUnqwcEGQKvY1daFlmuBwA28Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177385; c=relaxed/simple;
	bh=lgWpE2gY+g/2MbX+tAt1Noq8uPOKkbtQSpA48syYG+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT7gEH2L/3JS81E6730qDFvGGzqQtkOSI8kX0tmCFwPCH2PBJCoVTdUrqxSRf7JN909QB/dMRy+dZN0rsa6m/AsiknAEJ0pv4ovBfuuapHVkz3H4GvpUBJ5Q90B7Uzh4Fz6D9A4Fsu2x708hAjGVlxs91SiZ4gAorI93gDeIti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxDuxYwp; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxDuxYwp"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137eb0d76beso465156c88.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 18:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782177383; x=1782782183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33paqDjGP10yh/AMCFQnglsldxp5YtWteEECzRsr7y0=;
        b=BxDuxYwp1NqqVKsJ+/o0SwbCM1lOFvoelg7uEYdG4/NyBdhFSq1SkeCBFjqLdisNqD
         By4Ycg5tWe+Ln99wokg7yrqwHks0bfrzntBxnjXoWnmVAUcKPncjW5K83XkSAWK0Glxr
         Tk5lgtvDbbFCYRntZYgBGDbr53b54kzB0KgUku05Qlc3a4r8nA8OUxmxGbcq9/iHmLg8
         RkPdXZDNLNCusRdB3cTW/WCC9YD4hyn8dmBE7BDPSWeZ4nqBo85c3lQPcIELw9XT3S+c
         cYuJAnPmuqY6SQhTd5BXQDA0olYYpcUwSLY/58j/HdhbHG2r9ymipLcKO2bWYIu7V5WK
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177383; x=1782782183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33paqDjGP10yh/AMCFQnglsldxp5YtWteEECzRsr7y0=;
        b=PX8FZ4B4QxRlW6q0vEJdARXxHDB7WF6mLHo738k25R/xNWU/FN3UMcuYdI2aR1N4dE
         WJzSYPjr87ebWZCR91OjH5T2XONk4jrNsmnxHW/8ua3G36M+COlWnsWc/VOTCV+CdrnR
         DoCD0K2waPy3BrkLxWUCp60atPouZQo7iYleIqPcFLzhfWO0GAQZeke8fV+Jf7cxjVC7
         fnuJ8Pq/wv3bGvDLy2IQQH8ut9UfSepAnApglD+MByppq1LtH+CKS9/eULURjp7xBvrh
         j6noyEuYEx/owL9OGo8g+RoPn66+zEFbddJHSwqRf91BTJ3v/q3tQy4nlTTncoS9ey9Q
         IR0w==
X-Forwarded-Encrypted: i=1; AHgh+Rohzm+afzZ1w5/porPbOtMGEphPknlQiX4EsEpllj1aOqS1vA1DWOBiaC8VkzJkyEz0kezlxc3ad4kwvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz88TbiXoq5P61i9gRX5rfkg8DmM9NsHhC+UsdTNtZS7Mp72xl
	5BHzPpLdjRTtuDt9ewuZoFVG+FO8nDBxgxWdpi8mmzQ/rkrFLJmOTFpi
X-Gm-Gg: AfdE7cka05wQgS/YDsRdE4dEZr7QXxfpuvCE4BIujxq24r19Ycc7mvau0x7fHSWmMRX
	kTEDXPGpTFMSqRb1Xlk3pKeO28ZK9x3o6bJLDzlodRXGIqVVKvCxeQ2GVdKVD6c05/NhjR6pk18
	2Nf5gjWnR+kNus7mVs8xRDH0h2kRjy51NqnUTp5jVt+ONVkzEdcG8X921dxACa5uum9USUyaKE2
	MVrgo5SfdGyNoOZF2cg9iloSDvkR8+yAUWp8+EIKMfXj/SF0Ipbgdi7FU1qAMb4vbbYFEK6SF0C
	fvMbLbD+sRh5f/Kq7xruITuOGAKT+z1b2PLaEaWJqeG1Cydh6bkZdMq5mOe6IypintCGO4rkVia
	HrfXWqN9aRLUpe8bOfcNZWCWDCkGO+OVMm0QY7oDqNGjcAa3Cgj5+bX/0nq0IcOot99zKYdlaWe
	+nKPmPiUa3UxAhKW1csSJPkf9rdr+9qJ6g0jFY8KH1TKwaGf1Z5aFnXw==
X-Received: by 2002:a05:7300:642a:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-30c555b8663mr1397387eec.12.1782177383418;
        Mon, 22 Jun 2026 18:16:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d8d:3bdf:d563:1911])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm15845220eec.23.2026.06.22.18.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:16:22 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:16:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Wang, Jie" <jie.wang@intel.com>
Cc: Henk Vergonet <Henk.Vergonet@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com" <syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] Input: yealink - stop URB resubmission on completion
 error
Message-ID: <ajneBssfVm3NAEKa@google.com>
References: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
 <20260616110440.1073059-1-jie.wang@intel.com>
 <ajGfjuo3MTlezkYX@google.com>
 <DS0PR11MB64484A4A38381336F2AC0C3F98E42@DS0PR11MB6448.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB64484A4A38381336F2AC0C3F98E42@DS0PR11MB6448.namprd11.prod.outlook.com>

On Wed, Jun 17, 2026 at 05:49:07AM +0000, Wang, Jie wrote:
> Hi Dmitry,
> 
> Thank you for the review.
> 
> > -----Original Message-----
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Sent: Wednesday, June 17, 2026 3:17 AM
> > To: Wang, Jie <jie.wang@intel.com>
> > Cc: Henk Vergonet <Henk.Vergonet@gmail.com>; linux-input@vger.kernel.org;
> > linux-kernel@vger.kernel.org;
> > syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com; syzkaller-
> > bugs@googlegroups.com
> > Subject: Re: [PATCH] Input: yealink - stop URB resubmission on completion error
> > 
> > Hi Jie,
> > 
> > On Tue, Jun 16, 2026 at 11:04:40AM +0000, Jie Wang wrote:
> > > urb_irq_callback() and urb_ctl_callback() resubmit each other's URBs
> > > regardless of completion status. When the device returns a persistent
> > > error (-EPROTO), this creates an unthrottled resubmission loop that
> > > starves the CPU and triggers RCU stalls.
> > >
> > > Stop resubmitting on any non-zero URB status, following the standard
> > > completion pattern used by other USB input drivers.
> > >
> > > Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
> > > Signed-off-by: Jie Wang <jie.wang@intel.com>
> > 
> > It would be good to have a helper like
> > 
> > bool usb_is_permanent_error(struct urb *urb, struct device *dev);
> > 
> > instead of having this "switch" in all the drivers. It also unclear whether we should
> > not attempt to re-submit the URB on errors other than ECONNRESET, ENOENT, or
> > ESHUTDOWN.
> > 
> 
> For the helper - how about a local yealink_urb_check_status() in v2?
> A usb_is_permanent_error() in usb.h would benefit more drivers
> across the tree, but that's a larger effort best done separately.

I do not think we are in a rush to fix this: the driver is old and I
have no idea how many users actually have the device.

> 
> For resubmission - I'm thinking stop immediately on -ECONNRESET,
> -ENOENT, -ESHUTDOWN, and for 
> everything else retry up to 50 consecutive errors before giving up.
> Counter resets on any successful completion, so transient bus glitches
> recover but a dead device won't spin thThat is probably reasonable.e CPU forever.

That is sounds reasonable.


Thanks.

-- 
Dmitry
