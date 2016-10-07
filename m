From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sony: Update device ids v2
Date: Fri, 7 Oct 2016 17:49:36 +0200
Message-ID: <20161007154936.GC30411@mail.corp.redhat.com>
References: <1475779909-17907-1-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbcJGPtk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 11:49:40 -0400
Content-Disposition: inline
In-Reply-To: <1475779909-17907-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Oct 06 2016 or thereabouts, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Support additional DS4 model.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Roderick, FYI, on a v2, the format for sending the patch is:
[PATCH v2] HID: sony: Update device ids

Given that git will strip out the part in between braces, this way the
title of the commit stays the same :)

Cheers,
Benjamin
