From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2 5/6] HID: uclogic: discard the extra Pen input node
 on Huion tablets
Date: Sun, 01 Mar 2015 20:13:01 +0200
Message-ID: <54F356AD.8010509@gmail.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com> <1424977049-18648-6-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424977049-18648-6-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On 02/26/2015 08:57 PM, Benjamin Tissoires wrote:
> Some Huion tablets present 2 HID Pen interfaces. Only one is used, so
> we can drop the unused one.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This is what might have been plaguing GIMP users. Thanks, Benjamin!

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick
