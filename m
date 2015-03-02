From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] Input: psmouse - when comparing PNP IDs ignore case
Date: Mon, 2 Mar 2015 16:14:37 -0600
Message-ID: <20150302221435.GA668@unpythonic.net>
References: <20150228001852.GA18983@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150228001852.GA18983@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 27, 2015 at 04:18:52PM -0800, Dmitry Torokhov wrote:
> PNP IDs are supposed to be case-insensitive and so we should compare
> them as such.

Have specific systems popped up which need this fix, or is it just in
the interests of being correct?  If there are specific system(s) that
are affected, it would be valuable to list them or at least say so.

Jeff
