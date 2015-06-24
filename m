From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 01/11] Input: synaptics-rmi4 - embed the function modules
 in rmi_core
Date: Wed, 24 Jun 2015 10:10:18 -0400
Message-ID: <20150624141018.GA18091@mail.corp.redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
 <1435087050-11444-2-git-send-email-benjamin.tissoires@redhat.com>
 <1435139465.4528.64.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbbFXOKW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 10:10:22 -0400
Content-Disposition: inline
In-Reply-To: <1435139465.4528.64.camel@tiscali.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 24 2015 or thereabouts, Paul Bolle wrote:
> On Tue, 2015-06-23 at 15:17 -0400, Benjamin Tissoires wrote:
> >  drivers/input/rmi4/Kconfig      |  5 +----
> >  drivers/input/rmi4/Makefile     |  2 +-
> >  drivers/input/rmi4/rmi_bus.c    | 11 ++++++++++-
> >  drivers/input/rmi4/rmi_driver.h |  8 ++++++++
> >  drivers/input/rmi4/rmi_f11.c    | 10 +++++++++-
> >  5 files changed, 29 insertions(+), 7 deletions(-)
> 
> (These files are neither in v4.1 nor in current linux-next. I have no
> idea which tree this is for.)

Apologies. I should have mentioned that these patches are against
Dmitri's synaptics-rmi4 branch.

https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/?h=synaptics-rmi4

Cheers,
Benjamin
