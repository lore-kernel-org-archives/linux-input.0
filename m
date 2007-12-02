From: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 2 Dec 2007 19:06:51 +0100
Message-ID: <200712021906.52564.oliver@neukum.org>
References: <4752DB8C.50608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out001.kontent.com ([81.88.40.215]:56771 "EHLO
	smtp-out001.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbXLBSHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Dec 2007 13:07:25 -0500
In-Reply-To: <4752DB8C.50608@rtr.ca>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>, linux-usb@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Am Sonntag, 2. Dezember 2007 17:21:32 schrieb Mark Lord:
> I've grabbed mousedev.c from 2.6.23 and inserted that in place
> of the updated 2.6.24 source, but no change. =A0So it's not that file=
=2E

Are you really using mousedev and not true hid?
Do you see any other malfunction?

	Regards
		Oliver

-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
