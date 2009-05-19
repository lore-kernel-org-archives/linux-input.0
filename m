From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 19 May 2009 23:10:00 +0200
Message-ID: <4A132028.2040603@gmail.com>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A131D41.3030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46546 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbZESVKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 17:10:36 -0400
Received: by fxm2 with SMTP id 2so55902fxm.37
        for <linux-input@vger.kernel.org>; Tue, 19 May 2009 14:10:36 -0700 (PDT)
In-Reply-To: <4A131D41.3030305@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 05/19/2009 10:57 PM, Jiri Slaby wrote:
> I don't understand 'code 464' lines as well, how they did get there?

Ah, that's the fn key and there can be no misc for those, since they are
handled in the apple driver. Ignore me, I need to dig through the code
more carefully.
