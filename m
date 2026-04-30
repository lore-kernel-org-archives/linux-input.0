Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026ED7082D
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577441; cv=none; b=VQGGJBzEv86zBHXQ4BXXRVqezPDYtgyuJvzI5wHlcHyVubJrIpbN1le3S1I2GrIxlIH57EDtxOm/JRXx+8mxWT1WIDBcJMFvACb0v4WLakH2TsEQBG/gK6tEoUL8ofMfW/yY/Q5/ULgoNQd0j3khWF/zt388ZFgJ8RTj0vhgazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577441; c=relaxed/simple;
	bh=KJesWsbuDzQpkNp8k17t23YomF1fs6T42RqnGIbmT+M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ODqpCaN3g/KzChavr0496fkgczqJ8asNhELhfqbfDMdPbabUHXufpu6pblbWn9JG1BpmRtFmtsDDpkCCtoYwQpeCJRQWMZDZaB7vMzA+VMm3tQ7yQSRJ4EdkICqHkK66F0TICCsCep68YT078lejrcmptsTPcpRBMCDUlidiBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGbttGbc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGbttGbc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso8996365ad.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577439; x=1778182239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxuNSv+nlSzXKcfeo3FfuQD7X7e1NhixT6Zs+fqDCx0=;
        b=JGbttGbc+tG+gUSPvjEJ0qXv+SCE9UzH/cRWyBAWzAoDWWQ33JNC8IkdrLwQfqxJRC
         p83OVs2oBraSpsEuOlb7JLakBEXcH/pQ5USAFV3nmbM9776vNyU7CUgNM3aWTeYjIFRI
         DFyvzq+bpI7vaXxweouctvSwHNh0BiSdA24GR8dQdZijB3csvA5qffGFj4WknMk9nGfx
         zZiyxS85z6ybeDu7HcCB3q3WSyQpHFTxfL9ucSffQT8CHL4j/Ot5ureduJjjPPVrDZ2j
         Z5VniMYVqDuIUzTBBkPHoOrnrF6wLM5OfhfhOAWGMnKisu5YjMYM2rj0hFB1c31duSTL
         7o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577439; x=1778182239;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxuNSv+nlSzXKcfeo3FfuQD7X7e1NhixT6Zs+fqDCx0=;
        b=V9F4xswHNBI74IkDNxKF3KHxTWUMpbAsD/Ahw75lQpcqU0bLOKyqcgy0GKU/JdZIMX
         eRckFpsgww9GRIRc5mLUfCYt4MSVIwbuEx+0ex+kYOmVvRT920/1R897OiA+GzwSJ4zq
         cTnNMZE2Yl6aR8rdx/P1YReeUbyzQyQ8CgovxhxFhlpk4FQdOHy1/5u1QwVZKtFYSxMt
         XSccJN3IGlMEAEtpXp6d8L6DgGxRhUN3WNLPSTlSx34w3Adfd0Kt1VfP58K7Ty6lQ37m
         Qhk/sKeDyZp22FPB7dVNztZ9sA78X+iqAYnQ7LSiHSnuNno8lfAXmKhADty8HmtE6WkE
         +JFg==
X-Forwarded-Encrypted: i=1; AFNElJ+EQMCiZhs841TASt/iSy8jd+noa9Nh9WdRUzpNR7lQZZ6oUslqJynRwWJZKthmzlrwdkFKGHTvt90zEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJrTRUj4sCvVOHBPt2Fd2xBMVWmj7JtqxEvzcxYRMrRnjoBLv
	E5kDgmARR0kNO5twQZBJXEB8QXUQI5mxJwWmqNkFcsX4Z2QxJtTwxLb+
X-Gm-Gg: AeBDievFQk2otnmahIvGGwn8356HEqfkS6grQslS43nUUVQdLdDEdVCv5SYqye3sR7F
	1xpdQMFC/n8iYH0oIBVm01joZ20ckOO5ovR1MQgCpCo5oC4HzF1wpM3CrS3HJsmrW9ogPy2YiQR
	pfhAUbDlwBRKTVyxyXx7EaHl3sxwhie/K9KXl4XE9g5jQ7zEG6L83Sf/Akk5P+0DrWZixIDIAAQ
	bmZbCJcRVZeHRljt9Djw4nYmDmg/R5E3qnQAcE9qPlUUCjTKafyPBOPVvoZmgi/z5iHIeUthFAO
	fBcLNAcl29zN3jqVV+XB+t4/lvrKGGxi6zPq9U80i0d/lRLT6ZNXii7hWiDZvZ6IRiXKVPU+WgO
	77xzloxiC4J+/ionl6JgelDIRnwT3or5IHZjt8hOEOeCy3d5SKVF8TzjRkKMtidW0LSU9lUqKYw
	K6unTQhPix9cAYzYY6/rK28OI2oje8YjYoaRmk9/NmiM0j
X-Received: by 2002:a17:902:ef11:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b9a428297cmr33927525ad.1.1777577439347;
        Thu, 30 Apr 2026 12:30:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:53d0:4e4d::e3d:bc05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaec82sm3750855ad.24.2026.04.30.12.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 12:30:38 -0700 (PDT)
Date: Fri, 01 May 2026 01:00:31 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
User-Agent: Thunderbird for Android
In-Reply-To: <afJcj34Fc_aUMVhe@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com> <20260429175918.2541914-3-sanjayembedded@gmail.com> <afJcj34Fc_aUMVhe@ashevche-desk.local>
Message-ID: <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30 April 2026 1:01:27=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 29, 2026 at 11:29:16PM +0530, Sanjay Chitroda wrote:
>
>> hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
>> prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
>> during setup and release using device managed framework during drivers
>> fail, unbind or remove path=2E
>>=20
>> Register action with devm_add_action_or_reset() to release resource wit=
h
>> devres framework=2E
>
>=2E=2E=2E
>
>> +static void hid_sensor_remove_trigger_action(void *ptr)
>> +{
>> +	struct hid_sensor_common *attrb =3D ptr;
>> +
>> +	hid_sensor_remove_trigger(attrb);
>> +}
>
>Casting is not needed here=2E
>
>static void hid_sensor_remove_trigger_action(void *attrb)
>{
>	hid_sensor_remove_trigger(attrb);
>}
>

True, the cast isn=E2=80=99t required=2E I kept the typed variable for cla=
rity and type checking on devm_add=2E=2E API which pass void * callback and=
 remove trigger API which has struct hid_sensor_common=2E

Happy to simplify if preferred=2E

>=2E=2E=2E
>
>> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *=
indio_dev,
>> +				  const char *name, struct hid_sensor_common *attrb)
>> +{
>> +	int ret;
>> +
>> +	ret =3D hid_sensor_setup_trigger(indio_dev, name, attrb);
>> +	if (ret)
>> +		return ret;
>
>> +	ret =3D devm_add_action_or_reset(dev, hid_sensor_remove_trigger_actio=
n, attrb);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>
>	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, a=
ttrb);
>

Agree, will update in next series=2E
Thanks,
Sanjay Chitroda

>> +}
>
