From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3 ] hid: Multitouch support for the N-Trig touchscreen
 [v2]
Date: Wed, 20 May 2009 13:01:54 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905201300360.29030@twin.jikos.cz>
References: <2DCAF4CF-1408-4C2E-9713-5BD901899953@enac.fr>  <4A131388.1030709@seas.upenn.edu>  <1F279E42-BCE3-48DE-AFF3-1108BA000843@enac.fr> <4A131E89.7070208@seas.upenn.edu> <D8BE82D0-E301-4C65-A05C-D9B1CC925E14@enac.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-16515712-1242817318=:29030"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56791 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbZETLB5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 07:01:57 -0400
In-Reply-To: <D8BE82D0-E301-4C65-A05C-D9B1CC925E14@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-16515712-1242817318=:29030
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 20 May 2009, Stéphane Chatty wrote:

> Added constants to hid.h for all digitizer usages (including the new 
> multitouch ones), and updated hid-debug.c to support the new MT input 
> constants such as ABS_MT_POSITION_X.

Could you please also shortly describe in the changelog and in the hid.h 
as a comment, that these constants have not yet propagated into official 
HID standard (which is unfortunately quite outdated), but it is on it's 
way being pushed by Microsoft (and preferably reference the document).

Besides that, I think it is fine.

Thanks,

-- 
Jiri Kosina
SUSE Labs

---1747641777-16515712-1242817318=:29030--
