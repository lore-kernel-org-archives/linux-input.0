From: Paul Fox <pgf@laptop.org>
Subject: Re: [PATCH] forced recalibration for the OLPC hgpk touchpad
Date: Wed, 03 Jun 2009 23:58:33 -0400
Message-ID: <19417.1244087913@foxharp.boston.ma.us>
References: <3026.1243972079@foxharp.boston.ma.us> <200906030804.57340.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from colo3.heeltoe.com ([207.210.106.184]:36180 "EHLO
	colo3.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbZFDD6b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 23:58:31 -0400
In-reply-to: <200906030804.57340.dmitry.torokhov@gmail.com> 
Content-ID: <19414.1244087913.1@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dilinger@laptop.org, dsaxena@laptop.org

dmitry wrote:
 > Hi Paul,
 > 
 > On Tuesday 02 June 2009 12:47:59 pgf@laptop.org wrote:
 > > The OLPC XO laptop incorporates a combination touchpad/tablet
 > > device which unfortunately requires frequent recalibration.  The
 > > driver will force this automatically when various suspicious
 > > behaviors are observed, and the user can recalibrate manually
 > > (with a special keyboard sequence).  There's currently no way,
 > > however, for an external program to cause recalibration.
 > >
 > > This patch creates a new node in /sys which, when written with '1',
 > > will force a touchpad recalibration.  No other writes (or reads)
 > > of this node are supported.
 > >
 > 
 > 
 > Instead of creating a new sysfs attribute maybe we should make
 > the touchpad recalibrate upon resume (reconnect)? Userspace can
 > already request reconnect via sysfs.

dmitry -- thanks for the suggestion.

i took a look, and tried it.  the problem is that doing a full
reset of the touchpad takes quite a long time -- 1.1 or 1.2
seconds.  recalibration deprives the user of their touchpad for
long enough as it is -- i don't think we can afford that time.
(remember that this is a workaround for bad hardware -- the XO
no longer uses this touchpad at least partly due to this very
issue, but there are enough in use that we're still trying to
improve things.)

paul
=---------------------
 paul fox, pgf@laptop.org
