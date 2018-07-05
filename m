From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] HID: debug: check length before copy_to_user()
Date: Thu, 5 Jul 2018 01:47:01 +0100
Message-ID: <20180705004700.GB30522@ZenIV.linux.org.uk>
References: <20180702235937.111619-1-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702235937.111619-1-drosen@google.com>
Sender: stable-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 02, 2018 at 04:59:37PM -0700, Daniel Rosenberg wrote:
> If our length is greater than the size of the buffer, we
> overflow the buffer

Hmm...

How about this:
	buf = list->hid_debug_buf;
	if (list->tail < list->head) {
		ret = simple_read_from_buffer(buffer, count, &list->head,
					buf, HID_DEBUG_BUFSIZE);
		if (ret < 0)
			break;
		if (list->head != buf + HID_DEBUG_BUFSIZE)
			break;
		list->head = 0;
	}
	n = simple_read_from_buffer(buffer + ret, count - ret, &list->head,
					buf, list->tail);
	if (n >= 0)
		ret += n;
	if (list->head == buf + HID_DEBUG_BUFSIZE)
		list->head = 0;
instead?
