From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] ads7846: Add possibility to use external vref on ads7846
Date: Thu, 5 May 2011 11:44:07 +0200
Message-ID: <201105051144.08104.alexander.stein@systec-electronic.com>
References: <1304584346-10407-1-git-send-email-alexander.stein@systec-electronic.com> <4DC26902.3050201@cam.ac.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:33736 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab1EEJoK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 05:44:10 -0400
In-Reply-To: <4DC26902.3050201@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Am Donnerstag, 5. Mai 2011, 11:08:18 schrieb Jonathan Cameron:
> On 05/05/11 09:32, Alexander Stein wrote:
> > Just set vref_mv in your platform config to use external vref. Otherwise
> > the internal one is used.
> 
> Would be nicer to see this done with the regulator framework. But then if
> you have a use case on a board where that isn't available, then fair
> enough.

Well, for the regulator framework I would redesign the driver a bit. Currently 
the analogue inputs are displayed as mV in sysfs. If the current analogue 
input voltage is shown via the regulator framework the ads7846 driver itself 
can shows the actual ADC values. The latter ones don't need to know the 
reference voltage.
But I think this is a different problem than choosing the reference voltage 
for an ADC for what this patch is for.

Alexander
