From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2 3/6] HID: uclogic: name the input nodes based on their
 tool
Date: Sun, 01 Mar 2015 20:04:39 +0200
Message-ID: <54F354B7.9020402@gmail.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com> <1424977049-18648-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424977049-18648-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On 02/26/2015 08:57 PM, Benjamin Tissoires wrote:
> We append "Pen", "Pad", "Mouse", "Keyboard", "Consumer Control" or
> "System Control" suffix to the appropriate input node to match what
> the Wacom driver does and be more convenient for the user to know
> which one is which.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I read the kernel code and tested this a little. This looks and works fine.

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>
