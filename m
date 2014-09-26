From: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=
	<cywang@google.com>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Fri, 26 Sep 2014 12:07:55 +0800
Message-ID: <CAM2ehZYzaRw_kC9j=yu8u_8Zvk44CT28x=gp+Eku5UD3RR_LWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:64384 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaIZEIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Sep 2014 00:08:16 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so9459857obc.9
        for <linux-input@vger.kernel.org>; Thu, 25 Sep 2014 21:08:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

>>How about ABS_MT_PRESENT and/or ABS_PRESENT? It would complement TOUCH in the
>>case of hovering, allow the state where the tool is there but not touching, and
>>would unambiguously advertise the capability of detecting presence. It would
>>also be forward compatible with additional capabilities, such as reporting the
>>actual distance to the surface.
>>
>>Henrik

Or how about ABS_MT_TYPE which indicates touch type of a slot (finger,
hovering, stylus, ...)?

Chung-yih
