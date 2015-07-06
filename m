From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove
 redundant emulation code
Date: Mon, 6 Jul 2015 21:11:06 +0200
Message-ID: <559AD2CA.7000804@bitmath.org>
References: <556EF8AB.6090704@bitmath.org>
 <1433812075-16622-1-git-send-email-linux@mattwhitlock.name>
 <1433812075-16622-2-git-send-email-linux@mattwhitlock.name>
 <7271343.oGOpcDThz2@crushinator>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay6.public.one.com ([91.198.169.200]:49700 "EHLO
	mailrelay6.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbGFTMa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 15:12:30 -0400
In-Reply-To: <7271343.oGOpcDThz2@crushinator>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Whitlock <linux@mattwhitlock.name>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Matt,

> It's been four weeks, and I haven't heard back on this patch. I believe I've
> implemented what was requested. Is there a problem with it?

I thought you did get response on this patch set, concerning the fabrication of
force data? I seem to remember a mail from Dmitry about this, although I cannot
find it now.

I think your patch is a good reduction, all in accord with what we talked about,
but I have doubts that it will not create regressions. From what I have seen so
far, patch-wise, the best solution is to leave the code as it is.

I understand that the constraints now seem to depict the empty set, but maybe
there is a third solution.

Henrik

