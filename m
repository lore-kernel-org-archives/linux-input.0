From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Thu, 1 Jan 2009 12:35:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901011234010.32126-100000@netrider.rowland.org>
References: <495C8AE3.5000502@freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2269 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756003AbZAARf5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jan 2009 12:35:57 -0500
In-Reply-To: <495C8AE3.5000502@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Thu, 1 Jan 2009, N=E9meth M=E1rton wrote:

> >> Current result in case of 2.6.27: USB keyboard starts to work
> >> Current result in case of 2.6.28: USB keyboard does not work
> >>
> >=20
> > Is it input/HID, or USB?
>=20
> The same USB keyboard is working correctly with Clevo D410J laptop wi=
th 2.6.28,
> so I guess it might be an USB problem.

The dmesg logs clearly show that it is an HID problem.  In 2.6.27 the=20
device is registered with the input layer as a keyboard, but in 2.6.28=20
it isn't.

Perhaps a usbmon trace would help (see Documentation/usb/usbmon.txt).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
