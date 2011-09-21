From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [RFC] [BUG?] Sixaxis Value Ranges
Date: Wed, 21 Sep 2011 11:59:27 -0400
Message-ID: <CAEvUa7==YMJ97N33z9BRn9q2H2A4FETNWWGr8P29yTaQx4fFNQ@mail.gmail.com>
References: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
	<376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
	<CAEvUa7mtD1+ciKRn-S4gX9jWwFnecpDf_8w_NS+U55MdSxez4w@mail.gmail.com>
	<20110920125718.3243876084828c926b7e10dc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36307 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab1IUP72 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Sep 2011 11:59:28 -0400
Received: by pzk1 with SMTP id 1so2411134pzk.1
        for <linux-input@vger.kernel.org>; Wed, 21 Sep 2011 08:59:27 -0700 (PDT)
In-Reply-To: <20110920125718.3243876084828c926b7e10dc@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org

Hi,

On Tue, Sep 20, 2011 at 6:57 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> So David, did you solve this way?
> I read in Documentation/input/joystick-api.txt that JSIOCSCORR should
> not be used in a normal programs, only in calibration software.

I haven't added any ioctl calls to my programs yet, but I still
consider it for the future.  They aren't being widely distributed
(mostly on other operating systems where alternative input devices are
used anyway), so I am content to monitor API changes to the
calibration settings and adjust them as needed.

> Then I tried jstest-gtk and I was able to get all the values via the
> joystick device too setting minimum and maximum values respectively to
> 0 and 1023.

Using jstest-gtk (and/or jscal) is where I settled for the time being,
although I would like to eventually have better precision "out of the
box", either by a calibration in my applications or changing the
default correction values directly in the driver (which I think is
justified in this case).

Thanks.

David
