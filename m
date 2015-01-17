From: David Solda <dso@cypress.com>
Subject: Re: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
Date: Sat, 17 Jan 2015 18:00:29 +0000
Message-ID: <0F1DD2F3-F620-4161-A406-43C8F56A1304@cypress.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>,<20150117104415.GA2083@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:12579
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751348AbbAQTe1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jan 2015 14:34:27 -0500
In-Reply-To: <20150117104415.GA2083@hudson.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: Dudley Du <dudl@cypress.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Can we just reverse the prior change that caused the bug, or are you saying that the owner of the prior patch has to fix it?

Dave



> On Jan 17, 2015, at 2:44 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
>
> Dudley,
>
> Your patch series applies without issue but unfortunately I
> could not test them because I ran in to a bug created by someone
> elses patch (not yours) [1].
>
>  [1]: https://lkml.org/lkml/2015/1/17/24
>
> Once that issue gets resolved I would be happy to test your patch
> series.
>
>> On Fri, Jan 16, 2015 at 02:34:03PM +0800, Dudley Du wrote:
>> V18 patches have below updates, details of other updates see history list:
>> 1) Fix 'cyapa_runtime_suspend' undeclared compiling issue in latest
>>   kernel-next source code. Verified on next-20150114 with make C=1.
>> 2) Optimize enter bootloader failed for some chipset takes longer time issue.
> [...]
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
