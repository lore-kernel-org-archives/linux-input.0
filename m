From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/7] HID: provide a helper for validating hid reports
Date: Mon, 9 Sep 2013 14:33:32 +0200
Message-ID: <CAN+gG=H4iWCM_eE2V5dOPBuDZFRw+gkVpeY7XsnPn4DaCOLQ_Q@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-2-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:52859 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab3IIMdd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 08:33:33 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so4840454lbh.23
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 05:33:32 -0700 (PDT)
In-Reply-To: <1378312645-27736-2-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> Many drivers need to validate the characteristics of their HID report
> during initialization to avoid misusing the reports. This adds a common
> helper to perform validation of the report exisitng, the field existing,
> and the expected number of values within the field.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
>
> ---

Thanks for the v2.

I'm happy with this one.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
