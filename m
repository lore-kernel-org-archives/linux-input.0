From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH v4 0/2] Avoid selftests on some Asus models
Date: Sat, 1 Oct 2016 07:56:37 -0300
Message-ID: <20161001105637.GA2608@xfiles>
References: <1474809944-7357-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34168 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbcJALMu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 07:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1474809944-7357-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

ping?

On Sun, Sep 25, 2016 at 10:25:42AM -0300, Marcos Paulo de Souza wrote:
> Hi guys,
> 
> this is my forth iteration in this patch. I hope now this address all problems
> and, at least, most Asus models affect by this problem.
> 
> All models affected by this problem:
> A455LD
> K401LB
> K501LB
> K501LX
> R409L
> V502LX
> X302LA
> X450LCP
> X450LD
> X455LAB
> X455LDB
> X455LF
> Z450LA
> 
> Changes since v3:
> Add back all Asus models, instead of the dump decision of avoiding selftests in 
> all Asus laptops
> 
> Changes since v2:
> Avoid selftest in all Asus laptops
> 
> Changes since v1:
> Change kernel parameter i8042.reset to accept different values, instead of creating
> a new kernel parameter.
> 
> Please let me know if there is something that needs more polishment.
> 
> Thanks!
> 
> Marcos Paulo de Souza (2):
>   input/serio/i8042.c: Skipt selftest on ASUS laptops
>   kernel-parameters: Update i8042.reset parameter documentation
> 
>  Documentation/kernel-parameters.txt   |  7 ++-
>  drivers/input/serio/i8042-x86ia64io.h | 94 ++++++++++++++++++++++++++++++++++-
>  drivers/input/serio/i8042.c           | 38 +++++++++++---
>  3 files changed, 130 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4
> 
