From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/4] HID: uclogic: name the input nodes based on their
 tool
Date: Wed, 25 Feb 2015 16:36:52 -0500
Message-ID: <20150225213652.GE3097@mail.corp.redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424822730-14938-5-git-send-email-benjamin.tissoires@redhat.com>
 <54EE38FA.8070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55582 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbBYVhF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 16:37:05 -0500
Content-Disposition: inline
In-Reply-To: <54EE38FA.8070702@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Feb 25 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> >We append "Pen", "Pad", "Mouse" or "Keyboard" suffix to the appropriate
> >input node to match what the Wacom driver does and be more convenient for
> >the user to know which one is which.
> 
> As I said before, this is a very welcome change. Thanks, Benjamin!
> However, I'm not familiar with input_configured hook yet, so cannot give my
> Reviewed-by.

Well, the hook is called just before we present the input to the user
space. So the input node is already set and its corresponding report
has been parsed (or the whole descriptor has been parsed if
QUIRK_MULTI_INPUT is not set).

> 
> >+	if (suffix) {
> >+		len = strlen(hdev->name) + 2 + strlen(suffix);
> >+		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
> >+		if (name) {
> >+			snprintf(name, len, "%s %s", hdev->name, suffix);
> >+			hi->input->name = name;
> >+		}
> 
> I only feel a bit uneasy about duplicating buffer size knowledge here, as I
> said before, but the code is short, so it'll probably be OK.

I am not quite sure what you mean with "duplicating buffer size
knowledge"...

Cheers,
Benjamin

> 
> Nick
