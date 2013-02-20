From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 3/7] input: atmel_mxt_ts: check mxt224 family before
 writing touchscreen voltage
Date: Wed, 20 Feb 2013 14:31:41 -0800
Message-ID: <CANLzEks+tj9E2Uf5knJSROKXhNBA03fZ=iFO_LDOiNH=NUCv8g@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
	<1360246668-2291-4-git-send-email-pmeerw@pmeerw.net>
	<CANLzEktvtNQZvfeJ19U4=ah4tN5EigQvs-e+bNF_24NJrhxsSw@mail.gmail.com>
	<alpine.DEB.2.01.1302202315330.18013@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60665 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3BTWbm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 17:31:42 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so8394157oag.25
        for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 14:31:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.01.1302202315330.18013@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Yufeng Shen <miletus@chromium.org>

On Wed, Feb 20, 2013 at 2:22 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> Hello Benson,

>> The driver does read out a supported object table from the device
>> during initialize before handle_pdata. What sort of problem is there
>> in trying to write the voltage to a non existent T28 object?  If the
>> object is missing, then mxt_write_object for voltage should simply
>> return -EINVAL, and no harm should be done.
>
> a bogus error message is written, 'Invalid object type' in
> mxt_get_object()
>

Ah, I see. There is a dev_err in mxt_get_object. In that case, my
suggestion to check mxt_get_object will also throw the same bogus
error message. Maybe that should be a dev_warn instead?

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
