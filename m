From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 0/2] Synaptics RMI4 sysfs attributes
Date: Mon, 30 Jan 2017 11:08:41 +0100
Message-ID: <20170130100841.GB26482@mail.corp.redhat.com>
References: <1485630362-27423-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdA3KJq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 05:09:46 -0500
Content-Disposition: inline
In-Reply-To: <1485630362-27423-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Chris Healy <cphealy@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org

On Jan 28 2017 or thereabouts, Nick Dyer wrote:
> Hi Dmitry-
> 
> Here are a couple of patches to add sysfs attributes useful in implementing a
> firmware update system on Synaptics RMI4.
> 
> Changes in v3:
> - Improved commit message and added Acks/Testeds.
> - Stopped reporting 0 on success at Benjamin Tissoires' suggestion.
> Changes in v2:
> - Fixed bug in handling of update status in F34v7
> 

The series is:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> regards
> 
> Nick Dyer
> 
