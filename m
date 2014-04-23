From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for ALPS v7 protocol device
Date: Wed, 23 Apr 2014 12:57:19 -0700
Message-ID: <20140423195718.GA18953@core.coreip.homeip.net>
References: <1395219353-27683-1-git-send-email-qiting.chen@cn.alps.com>
 <20140422052604.GB32749@core.coreip.homeip.net>
 <20140422054244.GB21023@yabbi.redhat.com>
 <CAKvfdt+vztgQoys-u1i-4gwOYqYQuuu5f4bgcQyOtjrz3i-cZQ@mail.gmail.com>
 <20140422065503.GA27970@yabbi.redhat.com>
 <CAKvfdtJH4kA73FGCvLLTjN_UYyMt6wfv=Y33TApBfE9L_y61uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:54200 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbaDWT5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 15:57:23 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so1115964pbc.20
        for <linux-input@vger.kernel.org>; Wed, 23 Apr 2014 12:57:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKvfdtJH4kA73FGCvLLTjN_UYyMt6wfv=Y33TApBfE9L_y61uQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elaine Chen <elaineee66@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Justin Clift <jclift@redhat.com>, Qiting Chen <qiting.chen@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

Hi Elaine,

On Wed, Apr 23, 2014 at 02:47:26PM +0800, Elaine Chen wrote:
> Hi, Peter, Dmitry,
> 
> I see. As the xorg dosn't fully support Resting Finger now, will this
> patch be applied as a temp solution?
> Or this patch will be skipped. And we resubmit a new patch without
> kernel support of Resting Finger later?
> Please tell me. Thank you.

I believe the best way would be to submit driver changes without the
"resting finger" handling and work with Peter to add/enhance this
functionality in xorg driver.

Thanks!

-- 
Dmitry
