From: Chris Friesen <chris.friesen-b7o/lNNmKxtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Linux USB HID should ignore values outside Logical Minimum/Maximum
 range
Date: Mon, 24 Oct 2011 10:24:29 -0600
Message-ID: <4EA5913D.7090004@genband.com>
References: <op.v3q34la3dsdv5o@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <op.v3q34la3dsdv5o@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Denilson_Figueiredo_de_S=E1?= <denilsonsa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 10/22/2011 05:42 AM, Denilson Figueiredo de S=E1 wrote:

> It may even happen to send an out-of-range value for one axis, but a
> valid value for another axis. The code should be prepared for that
> (ignore one, but keep the other).

In this case what should be used for the "invalid" axis value?  The=20
previous value?

Chris

--=20
Chris Friesen
Software Developer
GENBAND
chris.friesen-b7o/lNNmKxtBDgjK7y7TUQ@public.gmane.org
www.genband.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
