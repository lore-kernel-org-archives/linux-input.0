From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
Date: Thu, 28 Jan 2010 22:53:18 +0000
Message-ID: <1264719198.29532.3149.camel@localhost.localdomain>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 <1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
	 <1264037759.1735.5008.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F-qt6i7J1wJoTyaV9iOGU/das+acoFTUjB@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gunn, Brian" <bgunn-2XggCk4BHTRBDgjK7y7TUQ@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ping <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2010-01-28 at 14:33 -0800, Gunn, Brian wrote:
> > > I just tested this patch with my device and it does work.  I had to
> > > slightly alter the data I send (had to add 0xA2 to the front of it),
> > > but then it does work.
> >
> > I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> > HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?
> 
> Actually for my application it doesn't.  I use HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT.
> 
> Perhaps allowing the user the choice of what do to here is more flexible.

Except that it would mean different code for USB and Bluetooth
versions...
