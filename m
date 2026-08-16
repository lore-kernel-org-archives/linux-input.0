Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710D34751F;
	Sun, 16 Aug 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786906378; cv=none; b=Re9wlzzCe0CHYOt69WMPyXLnMgAVsT19qGCdt/RhD0AiYgHbfSSfUREG12qkpfbXayU8xS711Q47wkRQOxgWtq8sTcV3vf8OSVjjEf9NRHlc6VfrE6HBytaum5laThJkCp2VmHAuEqr9kBpDk66wJ/0GZFubC+GzblycVjidWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786906378; c=relaxed/simple;
	bh=K4BJlteTHRXkKM7ZCE7ROh993plnZh6zChPcVsEDTBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ubdXVwXjroEZhTw3SZbswcmZ7xIaeK5Am0/jfw9BLa633LqsMOHAMaK80lUz82XkgHnVBhdlkYMaHxw8iSmjMmefain8G2aCQmSKLB2YJ/cMeSjHL5/kIxzhlJ5hy7EAPR5nL8bdQ9gcPhKpJMbf/aQJn/2eEfhgcSVXkoNOi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=DrR+icXJ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="DrR+icXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rogr93xEBCwuiAzKlLpwDJRo4Ap18TiIfPxr3bQ3Gb0=;
  b=DrR+icXJjD9DvXx9pPeQXPpa4E7e4yy0Na8HuhppenJY4JvIdl310EW/
   WXpVOKUEtCIz3jjtPDE3vEGpfIIMVMjgDOt6iolAFXt7DcAtMslpYwxnc
   hOFNCQVG29K+ef6L0kULlHJ4YNjbibhTRB4mxAyrax3LllgwMuxkPRXp4
   A=;
X-CSE-ConnectionGUID: wVRgbFu8RtCSiN88Q/8iAQ==
X-CSE-MsgGUID: TmkET2/mQGqULuPbm3w4TQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,227,1779141600"; 
   d="scan'208";a="290305522"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:52:51 +0200
Date: Sun, 16 Aug 2026 20:52:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH 02/21] HID: add documentation and Coccinelle script for
 FF registration race
In-Reply-To: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
Message-ID: <5e96c91-164f-9ec5-43e4-474189e2a337@inria.fr>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com> <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
> new file mode 100644
> index 000000000000..479f5d1e3184
> --- /dev/null
> +++ b/scripts/coccinelle/hid/ff_race.cocci
> @@ -0,0 +1,34 @@
> +/// Detect HID drivers that initialize force-feedback after hid_hw_start()
> +/// when HID_CONNECT_HIDINPUT is used. This is a lifecycle violation as
> +/// the input device is already registered.
> +//
> +// Confidence: High
> +// Copyright: (C) 2026 Gemini. GPLv2.
> +
> +virtual report
> +
> +@r@
> +identifier probe_fn;
> +expression hdev, flags;
> +position p1, p2;
> +@@
> +
> +probe_fn(struct hid_device *hdev, ...) {
> +  <...
> +  hid_hw_start@p1(hdev, flags)
> +  ...
> +  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> +  ...>
> +}


This seems unnecessarily costly.  The pattern can be just:

hid_hw_start@p1(hdev, flags)
...
\(input_ff_create\|input_ff_create_memless\)@p2(...)

Or does it matter that struct hid_device *hdev is the first parameter
of the enclosing function?

julia

> +
> +@script:python depends on report@
> +p1 << r.p1;
> +p2 << r.p2;
> +flags << r.flags;
> +@@
> +
> +# Check if flags include HID_CONNECT_HIDINPUT (0x01) or HID_CONNECT_DEFAULT (0x0f)
> +# Note: HID_CONNECT_DEFAULT is 0x0f, HID_CONNECT_HIDINPUT is 0x01
> +if "HID_CONNECT_HIDINPUT" in flags or "HID_CONNECT_DEFAULT" in flags:
> +    msg = "WARNING: force-feedback initialized after hid_hw_start() with HID_CONNECT_HIDINPUT. Input device is already registered at this point. Use .input_configured() instead."
> +    coccilib.report.print_report(p2[0], msg)
>
> --
> 2.55.0.629.g250fe7f194-goog
>
>
