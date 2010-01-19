From: "Gunn, Brian" <bgunn-2XggCk4BHTRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Tue, 19 Jan 2010 09:05:15 -0800
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9E@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 ,<1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9D@EXMBXSD.dm.solekai.com>,<1263920596.1816.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263920596.1816.56.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ping <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> Bastien Nocera wrote:
>On Tue, 2010-01-19 at 08:36 -0800, Gunn, Brian wrote:
>> I tested this with a Bluetooth remote control.  As I understand,
>> reports can be written to either the interrupt or control sockets.
>> I'm happy to test other changes to let this be selectable.

>Could you expand slightly on that? What make/model? What sort of tests
>did you do on it?

I used a custom remote control under development by the company I'm contracted to.  We have custom HID output reports that trigger actions on the remote.  I was able to send the output reports and get the behavior I expected on the remote.  I have no faith that the company developing the remote implemented their side correctly and would like to try it with the control socket instead.

Brian
