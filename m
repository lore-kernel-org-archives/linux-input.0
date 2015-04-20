From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] Input: elants_i2c - zero-extend hardware ID in firmware name
Date: Mon, 20 Apr 2015 12:27:10 -0700
Message-ID: <CANLzEktduDHacrsAAB3e7h-e+SZPAOnRG0K-q7h6k92wVVo4OA@mail.gmail.com>
References: <20150418034336.GA31454@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37759 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbDTT1L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 15:27:11 -0400
Received: by igblo3 with SMTP id lo3so69292740igb.0
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2015 12:27:10 -0700 (PDT)
In-Reply-To: <20150418034336.GA31454@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Scott Liu <scott.liu@emc.com.tw>, Charlie Mooney <charliemooney@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Apr 17, 2015 at 8:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Let's zero-extend hardware id number when forming firmware file name,
> to avoid kernel requesting firmware like "elants_i2c_   0.bin", which
> is quite unexpected.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Benson Leung <bleung@chromium.org>

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
