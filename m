From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [PATCHv5] input: ROHM BU21013 touch panel controller support
Date: Mon, 4 Oct 2010 06:52:45 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057919238FA5A3@EXDCVYMBSTM005.EQ1STM.local>
References: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
 <4CA6DE75.8010508@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:35140 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751341Ab0JDEyW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 00:54:22 -0400
In-Reply-To: <4CA6DE75.8010508@euromail.se>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>

Hi Henrik,

Thanks for your commenst.

> -----Original Message-----
> From: Henrik Rydberg [mailto:rydberg@euromail.se]
> Sent: Saturday, October 02, 2010 12:56 PM


> > +	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);
> > +	has_y_sensors = hweight32(((buf[1] & BU21013_SENSORS_EN_8_15) |
> > +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >>
> SHIFT_2);
> > +	if (!has_x_sensors || !has_y_sensors)
> > +		return 0;
> 
> 
> I believe this line will lead to fingers stuck in the down position.
> 

This case is only used when there is only x or y -co-ordinates or both are null.
This case is coming either before pen down report or after pen up reporting.
So, this is not an issue.

Thanks & Regards,
Naveen
