From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/4] Support new Alps HID I2C Touchpad device
Date: Fri, 23 Jun 2017 10:15:34 +0200
Message-ID: <20170623081534.GJ26073@mail.corp.redhat.com>
References: <1493278834-8523-1-git-send-email-masaki.ota@jp.alps.com>
 <alpine.LSU.2.20.1705111035050.26873@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753551AbdFWIPm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Jun 2017 04:15:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1705111035050.26873@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Masaki Ota <012nexus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On May 11 2017 or thereabouts, Jiri Kosina wrote:
> On Thu, 27 Apr 2017, Masaki Ota wrote:
> 
> > Hi, Benjamin,
> > 
> > I modified the patch and added the code that supports Alps USB Touchpad as PATCH 4/4.
> 
> Hi,
> 
> could you please reformat / extend the changelogs of individual commits a 
> little bit, so that they are more in line with our usual commitlog style 
> (not brief bullets, but a regular text), and try to explain in a few more 
> sentences what are the changes about?
> 

Hi Masaki,

Have you made any progress on this series?
It seems some users need it or they have suspend/resume issues:
https://bugs.freedesktop.org/show_bug.cgi?id=98099

An update would be greatly appreciated :)

Cheers,
Benjamin 
