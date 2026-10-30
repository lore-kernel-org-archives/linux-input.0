Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371141;
	b=nxp+58hIr9+iB9JXfurf14aSCAc5X4ED+mmUJGL/HFVUHiLivQ+fiZ6vwkp2sIuM5ZeY
	 6gV0sXqbtVvrqb5z5kberPRfGgahNtczEuL1nvvLFEs/jELtqEkj3R+/DRLLtrWZZtmsw
	 v5drY0RSkzCaCCUMw0JcvK/yTHAjpMNCEcevH+oTRjLThyO6OZYt1uIYIJ5vhl6JSmXh7
	 3hW+f3zVHmBqghH0GN0rCuWR9Ir3VR1UM5sS2/L+LnW4ZStZCEjySUd0KhzzoAIz4YwTG
	 cAtDDyPZbGeMNNrx9T0Gs97NQCtKIKyACbthEoSfYH/ATTmJifTWSDsxl24pyRIe5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371141;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=X+jL5QP1zfJdaJr6lj9TVIyYJXOirbw2bMK3zOxIKfs=;
	b=NyRHMDX/DOVChVId9G2Jk9GEFN0gvzrJR5MvQ3bXvmn7X5ww6CXCvuO27O3+xJpgqs+e
	 0Kul+ov1MAC9OZmkQq8Tyd6GjkvsXH38dMR9e6YrWswt43Jd8VRnFlGZ/uMhyu7ePwdGh
	 JQP/wNTVqwA05jpboljQyqU3sEVDniuUXnanTfKkD6X8G0V09qsg/4O2F+rg8Sn/UlnTi
	 piKDboUG3b8UuD1F1EK5IzFgxkt7qqyRLmL/u9pdtyntFVEo+0q6JEugXMwWXtchzIRW7
	 jMn+xZxoVtIwk3/uoN0+4O7a02fQk7XvQ/J99mNw1TW/yQmEPW9xN5h81AhbLV7p+kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="KxZxh/Ba";
	arc=none smtp.remote-ip=95.215.58.139
Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93182606A31F
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 14:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93182606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KxZxh/Ba
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CZy0RET86SHEJl5kUZciGQmm2ZhwcBOzdF3dtCdmBiY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793371138; v=1; x=1793975938;
 b=KxZxh/BatzLytPQ4Nb0VSLv/tPnefBqmyi4sECimMXtm3nlOfeKd1lXx1YArst4FDcNsGO6R
 C7Ml88uWIf1o1dxG6+GLyqeXIqcDVFM4DyPIo4wnAFwOAVdeD0N/CAF+O55vpuoK16Nktr3JNJc
 vIOgxmRqKxkoVeIU4sr4ybr0=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aa867f3a93bbc39b;
	Fri, 30 Oct 2026 14:38:58 +0000
X-Mizu-Trace-ID: aa867f3a93bbc39b
X-Migadu-Flow: FLOW_OUT
Message-ID: <6361f6a6-3cfb-4eaf-babf-be548f28f2c0@linux.dev>
Date: Fri, 30 Oct 2026 15:38:57 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/18] HID: asus: add support for response curve
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schwartz <matthew.schwartz@linux.dev>,
 Denis Benato <benato.denis96@gmail.com>, Jonathan LoBue
 <jlobue10@gmail.com>, Khamunetri Clark <khamunetriclark@gmail.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>,
 Hans de Goede <hansg@kernel.org>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-8-denis.benato@linux.dev>
 <7688fc40-c439-005f-6a78-efdc39356694@linux.intel.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <7688fc40-c439-005f-6a78-efdc39356694@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/26/26 14:06, Ilpo Järvinen wrote:
> On Sun, 25 Oct 2026, Denis Benato wrote:
>
>> ROG ally devices allows configuring the response curve of both joysticks,
>> therefore add the ability of userspace to modify the response curve by
>> exposing relevant sysfs attributes.
>>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> Signed-off-by: Luke Jones <luke@ljones.dev>
>> ---
>>  drivers/hid/hid-asus.c | 297 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 294 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index b4bc89ec28bc..e1883ee20413 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -22,6 +22,7 @@
>>  
>>  #include <linux/acpi.h>
>>  #include <linux/cleanup.h>
>> +#include <linux/ctype.h>
>>  #include <linux/device.h>
>>  #include <linux/dmi.h>
>>  #include <linux/hid.h>
>> @@ -185,6 +186,18 @@ struct asus_touchpad_info {
>>  	int report_size;
>>  };
>>  
>> +struct ally_joystick_resp_curve_param {
>> +	u8 move;
>> +	u8 resp;
>> +} __packed;
> Add include (if I didn't mentioned it already with some earlier patch,
> I don't recall anymore :-)).

Which one? I only see drivers either not including it directly or highly hardware-coupled including the one
for the architecture, what about a driver that must work for x86 and arm64?

