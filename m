From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: Elan TS driver patch
Date: Fri, 10 Oct 2014 15:11:37 -0700
Message-ID: <20141010221137.GD38320@dtor-ws>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw>
 <20141007160358.GA16469@dtor-ws>
 <006001cfe294$13720370$3a560a50$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58975 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaJJWLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2014 18:11:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so2535058pad.11
        for <linux-input@vger.kernel.org>; Fri, 10 Oct 2014 15:11:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <006001cfe294$13720370$3a560a50$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ELAN =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input@vger.kernel.org, bleung@chromium.org, 'Charles Mooney' <charliemooney@google.com>, "'Jeff.Chuang'" <Jeff.chuang@emc.com.tw>, =?utf-8?B?J+aigeWNmue/lCc=?= <paul.liang@emc.com.tw>

Hi Scott,

On Wed, Oct 08, 2014 at 09:06:20AM +0800, ELAN =E5=8A=89=E5=98=89=E9=A7=
=BF wrote:
> Hi Dmitry:
> 	Thank for reply. Please let me know if anything needs we do.

What is the part name/number of this touchscreen. As the example with
touchpad shown us device tree folks are not happy with the generic
"i2c_touchpad" or "elants_i2c" and would rather we used proper model
number in bindings.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
