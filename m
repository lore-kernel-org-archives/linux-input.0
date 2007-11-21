From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add i8042.noloop quirk for MS Virtual Machine
Date: Wed, 21 Nov 2007 14:24:08 -0500
Message-ID: <d120d5000711211124r5f97a79eh12e75ea4bec19499@mail.gmail.com>
References: <Pine.LNX.4.64.0711171045390.12807@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:46332 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbXKUTYL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2007 14:24:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so176523ugc
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2007 11:24:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711171045390.12807@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Lawrence Steeger <vendor@russte.com>

Hi Jiri,


On Nov 17, 2007 4:46 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> From: Jiri Kosina <jkosina@suse.cz>
>
> Input: add i8042.noloop quirk for MS Virtual Machine
>
> When booted under Microsoft Virtual Machine, the noloop quirk is needed,
> otherwise PS/2 mouse is not properly detected.
>
> Reported-by: Lawrence Steeger <vendor@russte.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>

Applied to my "for-linus" branch for .24.

-- 
Dmitry
