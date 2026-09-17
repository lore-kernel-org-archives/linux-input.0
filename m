Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF94AF148
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641959; cv=none; b=nmICkSzQxFsU0+aS7eRK/UUlm1FRYrX+yMmX0AkwU37Bb5gKrGtX8RHRijk2LqIPEYcwRSzexfKQFLAQbLD2UoweRzuVPv4/9j9uhFNi2fElUzCjjE3yx1whrcThu+gbwqFV1tjLkGCafsJzeATNn3qR1vyr24nmM30DZlyvyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641959; c=relaxed/simple;
	bh=ovLCQUCDOqMhKBRej79kaKDsjzw8umfUUAGzKBcmu/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXtwvHvtG7viE7zWsxsjbssX9uXnJ+a03E+q1r6m0+2lE67LBQO7NxAZj5c/QjptXiqFFY4KSQ0zSRIqPnMh1bZSVFkK7p//eW/dAsiC7/EVeRFIJEfvugMj061rJmfiMjAmmZiSi/MIYAzR6rpsnWvMu+XSc6EwhXw5NnVGSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqFRB559; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qdRhtmaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqFRB559";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qdRhtmaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789641956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DZXDm9UY4DlpHYYNoTlamnKULIP4yXFvx7qTD+Fjiqs=;
	b=NqFRB559RpDHqLBJQO6ZL76UDJOfEP+K08cGuflhDZGNR3hd52u3BcHUZhfXPQ9VmFG75Q
	0ppAMFJWju+Kb/+3MuOpk3kfI/R+ng41Y2GtcRXld+izw+Ws+hi9mghV98ev890swqrjYe
	F0Q6mkWBOF+oAasB4S+u3IDIFTssDZw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-6wTsts5GOZSxOkmt2Ajjog-1; Thu, 17 Sep 2026 06:45:53 -0400
X-MC-Unique: 6wTsts5GOZSxOkmt2Ajjog-1
X-Mimecast-MFC-AGG-ID: 6wTsts5GOZSxOkmt2Ajjog_1789641952
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4870142f030so504592f8f.2
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789641952; x=1790246752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZXDm9UY4DlpHYYNoTlamnKULIP4yXFvx7qTD+Fjiqs=;
        b=qdRhtmaKEtD5ZqbFoHFM3j7Py7C6eXOldaiPZnuc+G7C8YzKVgBeBVnhd0Phgnzu96
         pxzUh+KXBmGayXd+RkvbdCLFN7SGS5/eIpXuqvhQDLFlSYQBS7w8n++FdjEd697/XQR0
         DywPhOkJJttulcA/jJ0LZY0bgNbCHzJAWFqU7w/TEeJeCbTRUhKyRV1BjQgm134PzJFG
         kZ+AQEkbv3HPrGIL2kedzNncChVWTieUXSMD+CaH/qF5kanRgYu3E4mC5k+F4OtY+BNM
         MmF6dlY9iBYzvLw2SuQ4xFqMB0dF5O5S7ZnCRCTWh00oUUrFHRpwfOWXnQ88+//kP/FP
         Rp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789641952; x=1790246752;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZXDm9UY4DlpHYYNoTlamnKULIP4yXFvx7qTD+Fjiqs=;
        b=MoyQLF9iXYoXR0IvCE6KR3QrbZPSFB7misc3CUcbZtl60Xxw2MK9Cd5018JiQ6iXn2
         VxHwkK916moGrlg0PHnQbV9jRRV6yj4EMmD8WrS64oHAsqgXnalno/o0PGO5x7YYIZb9
         JqXH8fOpx+9Fre/furxJufS3aR1Z12onFi3WXBehMcZRONPNClbZMEsS2GKeW/8ya3fR
         eeu1EVc9HS3uORN1PQPDlZ4iVYBDbyUeA14YK6JnF+w5EvQYOrACFEeqNErL8iVIXTGQ
         lW9RUKvm9mHHleX7lSLCa1wBtpbMjMaRvPhdQ+ZGe/kRFGBDSUHY/cGva3dRzPhI3E2H
         WzRg==
X-Forwarded-Encrypted: i=1; AKwUvBw+flCGF8eUBEIhsVYHoEQWbOgd0LvklLpjxaqBh/GurywsvHAEE7OckF4UFWPXulBG3MsUeeqITyOILA==@vger.kernel.org
X-Gm-Message-State: AFuF++lqJ6jCaBa3Sk50ldIW91Eup4ezIosSaMNRWt2xVj+Klmzjfzz7
	5UAEVG6YxP8BddqEASxEXqo0pVr0/C191UYRBKB4GvCPx3jqKoi201PEeo5zprWmhbfRae/n/1a
	0cIkTkH0JuaiqZvXrBw7S/3WGDN4ouSUHKPJSxT4aEUfg81WyAEXQMp/Mb8Tfo34F
X-Gm-Gg: AYBFou3GBEp882jTPw7eRkgb4WogJXgZ2IzcGI9UGJM8WjbnGmrzXVnG5JOKM7jjlhO
	SDPnuojuxBYrBQxHZsDvyzJprOOiSBVvXoG+wngDfLKeiKxtDXiUcJKANyAm+WP/tYdFh7Z/C6N
	BrdOaN8e4nga/Tx7vtu5RRTVy3bvaneY0VxA02vN35j/lWBD/oYzOFQTQ5XaR11hBI1d8qkPser
	0VnT4frQjESo1WCvtXFs9c6N4X3u3AZqYgl+rfLoMln7jxuO5s36LnH4aVnG0hmtZLPujN3g6iH
	jIfWQdgTYUh7TKB7XxThpbLSl5r/MK0Zcj5O9LVghc0qUMbTYBwL6abMg9OJsUaF4CMH5TSlkg=
	=
X-Received: by 2002:a05:6000:2213:b0:487:11db:986c with SMTP id ffacd0b85a97d-48711db994bmr4933695f8f.51.1789641951951;
        Thu, 17 Sep 2026 03:45:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2213:b0:487:11db:986c with SMTP id ffacd0b85a97d-48711db994bmr4933646f8f.51.1789641951396;
        Thu, 17 Sep 2026 03:45:51 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm15421889f8f.2.2026.09.17.03.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:45:50 -0700 (PDT)
Message-ID: <44324b19-6a5e-44e5-acf5-b17584610569@redhat.com>
Date: Thu, 17 Sep 2026 12:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/19] HID: Add documentation for Lenovo Legion Go
 drivers
To: Derek John Clark <derekjohn.clark@gmail.com>,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bentiss@kernel.org, hughsient@gmail.com, jikos@kernel.org,
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 mpearson-lenovo@squebb.ca, pgriffais@valvesoftware.com, shaohz1@lenovo.com,
 zhangzx36@lenovo.com
References: <20260310072937.3295875-17-derekjohn.clark@gmail.com>
 <7dc9bd14-b21f-461a-9794-070f43db4826@gmail.com>
 <CAFqHKTmBBEHJgypooELKa7fU3oELnVk7bjfZwHsFD9Y0b1c3Xg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFqHKTmBBEHJgypooELKa7fU3oELnVk7bjfZwHsFD9Y0b1c3Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi!

On 12/03/2026 23.57, Derek John Clark wrote:
> On Wed, Mar 11, 2026 at 7:44 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>> On Tue, 10 Mar 2026 07:29:34 +0000, Derek J. Clark wrote:
>>> Adds ABI documentation for the hid-lenovo-go-s and hid-lenovo-go
>>> drivers.
>>>
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> ---
>>> v3:
>>>    - Remove excess + from every line of patch.
>>> ---
>>>   .../ABI/testing/sysfs-driver-hid-lenovo-go    | 724 ++++++++++++++++++
>>>   .../ABI/testing/sysfs-driver-hid-lenovo-go-s  | 304 ++++++++
>>>   MAINTAINERS                                   |   2 +
>>>   3 files changed, 1030 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>>
>> This (commit 168c91839139 in next-20260311) causes a lot of new warnings
>> in "make htmldocs" such as:
>>
>> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
>> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
>> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
>> [snip]
>>
>> Please fix.
>>
>> Thanks, Akira
> 
> Akira,
> 
> What would an appropriate solution look like? There are two separate
> drivers in this series that are modeled to provide a sysfs that is as
> close to each other as possible. Because of that, they do end up
> having identical attributes for many of the implemented features.

Just an idea, not sure whether it's feasible since I don't have the hardware 
for checking: Looking at drivers/hid/hid-lenovo-go-s.c and 
drivers/hid/hid-lenovo-go.c, it seems like they use different vendor IDs 
(USB_VENDOR_ID_QHE vs. USB_VENDOR_ID_LENOVO), so maybe the "<vendor-id>" 
part could be replaced with the real value in the entries to distinguish 
them in the kerneldocs?

  Thomas

