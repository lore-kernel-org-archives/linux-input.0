From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Tue, 13 Sep 2011 10:09:11 +0200
Message-ID: <20110913080911.GA4986@polaris.bitmath.org>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:53480 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1IMIFq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:05:46 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 9B8C2EAF12
	for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 10:05:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com

Hi Jason,

> Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
> hardware supported by the Wacom driver. The DIRECT property is
> assigned to devices with an embedded screen (i.e. touchscreens
> and display tablets). The POINTER property is assigned to those
> without embedded screens.
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---

According to the discussion leading up to the properties interface
(https://lkml.org/lkml/2010/12/15/263), a tablet is a direct pointer
device, as opposed to a touchpad, which is an indirect pointer
device. The distinction determines the direction of two-finger scroll,
for instance. The question is then what behavior should be assigned to
a large tablet without an embedded screen. It should have POINTER set
for sure, but should it also have DIRECT set?

Thanks,
Henrik
