Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24043353A60
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937109; cv=none; b=Reim1B1yXXRgKi3jYxoFer0FS578Squ8iHdT90PUk2QZHgG/FCAZ8FOSCxRSh5vyrny7RBBrp8Xs++MIYnZ0hLOuCT4kogdYwWTOEd2n91kkcyXuILyV72BRPmDkc81y0XqcI122n3ecvCZj6vOUz94nea/WvC5BH7l0KAze5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937109; c=relaxed/simple;
	bh=wSN3htHchl2kAqK/XJ3tYkLxdnsMENV3rlMxFKhxI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2WiCmgkY6QbyLR8Q5nW6UIotQPdEJQJ7hXrFBv4yCQIkL90MAyI2e1eNCunLZix7iUvamHgCRxONgSHk2Wo2Qqux23Xk/bfhzi94rHKgeaUk0pyEvjyLMwU/6KqlkZpViL7dx9apYJnThcHPdhyoPe47jkm2FMndxVHaymJ6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT417p/U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT417p/U"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacf197759so14180525ad.2
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784937107; x=1785541907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jol9FmBVVHf5WmK/OKXO3GCBjpOStMY2uEtWdaHWCpo=;
        b=IT417p/UlsQ5VMBGVR177R8Uf6sKjK2roFgRVdu6lCqwU9Mb9l385Zzfnke7XHkMnm
         hOtJcF1UUUN+4q/2oHNgtoa2ZUAhGKrN3rBwKNVpyLIlxLTOsWveb4HFhGTSoQErLdN7
         8RBJv5tgr8FNLVq/UJQ3zB4xIZoNfNXfcv4CCnFL14Xu8kosLR+cX4Z+Wfsos57oCxKN
         agi7S6mdTUYYvtE4D+OzUj+T8GAzgf13EjwaA6VhaHtIO+bkE2Igf1V8Bi9RknSbT1jI
         7ZoDup9DmNCVkm8cO/QV0IY8QYaJhchRp1qz7+NdH6fzzb+THaheAacLSJZ1k4GXxti5
         q3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784937107; x=1785541907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jol9FmBVVHf5WmK/OKXO3GCBjpOStMY2uEtWdaHWCpo=;
        b=HiHIJgJG2l1sYnEnibcNYw9pmSDbjAcyHoFaPfA8kP3HKnC7mEE2LcqRLVtQwE/Aoc
         Wq9+tZ95ViuJajl+lXR9ZflCsXHCOk38b0kVnIzNxaKIY/IzikbOp5lR0ZQ8SVaKzdG1
         wBi8oKTiC/u9PVAID93poH6gk1YwBmQNa4bJzb+uCJaWf7U4Aab2MoWLLIFWWaKBWaeH
         LGvz3TJo/HpVq5Nw2ZmfXuYu7goZWLS3L1Nqpg7aK+37m9HJOuy/Xf/cJAMm/HIP3qlc
         5i0LW7jFWkTp9+aOuU09dQNZRH2UOC/hJui9htYi9o/iK9MYLUk9erQLHJkcuzAcXkpA
         WZng==
X-Forwarded-Encrypted: i=1; AHgh+Rrh65IrgR6q+1QI5FCtiGyoUpmGc3uYf4HxIY47p8fixyJly+cLbYMmeg8YSZUuErKDojocic7UpjITuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAYk0uIZB8Y4T67Ap4f6jOX/5FUF92AWJDS5jl6sumhjsaW/r
	CKJUq+Lt2RVD7JWuvxu3Sroxz1WbOfKr2Ty/LRVEJ+jKUmUJU5KMnmIAPgsvQw==
X-Gm-Gg: AR+sD12+WbBF/6rGjYgMQcgyJ0XZL8ZGyAVXDkrcJ5xuWBe0AhkBEQGEW0UUFvcK22S
	p8kQ0LkVlpOX5nkqWTIKYiPmnyu5F+/+s0Co+gTLBPcqeXUy9Nu4YnMEJZybLiswj8sd+YBzoJ7
	CdLdS3qnhnSRhjWcZ+W1TvDtGtNIVu1dYcC/enqfKQx4CCxoqnDbdiXQGvjcUrgJ5oSKbxFfZNR
	UH48wkywFG8TwG1QvaCEvOL2mupW7rYuUnrWK1SFaFIXn6m8YCeswkUKiCT7RNaRJmmmNOnrLaJ
	Zw5c2K1MgIUG5GMSuw8RbQZ4c5VjTHIe7wbxl2GhMb15Cxn9vycRc4iVwhxeuAFP1Y9Pei7nzjz
	NuSwRLk9l7PVC1Q0wBY0G0yg8IbktfZHIYuCKX2n5hS+1dnwRv+5iJ4sVo6A6vKdT1noY6Tvcpq
	rip+knnt0TDvGhXSQkWG8aCaH2jamSWDQoyveZUUkbJZE=
X-Received: by 2002:a05:6a20:a128:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3c67d9b3d98mr447470637.15.1784937107350;
        Fri, 24 Jul 2026 16:51:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e878esm3431688eec.3.2026.07.24.16.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:51:46 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:51:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: sashiko-bot@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
Message-ID: <amP550_hsqLYAKbK@google.com>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
 <20260717050748.5DC071F000E9@smtp.kernel.org>
 <amGrm7qnjHvXPYeX@quokka>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amGrm7qnjHvXPYeX@quokka>

Hi Peter,

On Thu, Jul 23, 2026 at 03:54:37PM +1000, Peter Hutterer wrote:
> On Fri, Jul 17, 2026 at 05:07:47AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] The patch provides an incomplete mitigation for CVE-2026-50292. It sanitizes the `phys` property to prevent udev property injection via control characters (newlines), but completely fails to sanitize the `name` and `uniq` properties, which are also exported to uevents and controlled by userspace.
> > --
> > 
> > --- Patch [1]: [PATCH] Input: uinput/uhid - disallow control characters in phys paths ---
> > commit 1a76e90e7acc09a84a52efddc46e598419020a19
> > Author: Peter Hutterer <peter.hutterer@who-t.net>
> > 
> > Input: uinput/uhid - disallow control characters in phys paths
> > 
> > This commit sanitizes the phys property in uinput and uhid devices to replace
> > control characters with '?'. This prevents userspace from injecting malicious
> > udev properties via newlines, which previously triggered CVE-2026-50292.
> > 
> > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > index 37b60c3aaf66a..baf1fe8290f75 100644
> > > --- a/drivers/hid/uhid.c
> > > +++ b/drivers/hid/uhid.c
> > > @@ -518,6 +518,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
> > >  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> > >  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
> > >  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> > > +	input_sanitize_phys(hid->phys);
> > >  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
> > >  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but while this successfully mitigates
> > CVE-2026-50292 for the phys property, does it still leave the name and uniq
> > properties vulnerable?
> > 
> > In uhid_dev_create2(), the user-controlled ev->u.create2.name and
> > ev->u.create2.uniq strings are copied directly without passing through a
> > similar sanitization function.
> > 
> > Additionally, in drivers/input/misc/uinput.c:uinput_dev_setup(), the name
> > property is also set without sanitization:
> > 
> >     dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
> > 
> > If a user with write access to /dev/uinput or /dev/uhid sets the name or uniq
> > properties to strings containing newlines, wouldn't this still allow the
> > injection of arbitrary udev environment variables when INPUT_ADD_HOTPLUG_VAR
> > formats them for uevents?
> 
> name and uniq are controlled by the firmware and thus by the vendor and
> control characters (or at least non-ascii) may be legitimately present.
> There is no such thing as a sanitized name.

I think if we sanitize phys we should also sanitize the others because
it is not only hardware controlled, we do have uinput and uhid. Also USB
hardware might be hostile...

Thanks.

-- 
Dmitry
