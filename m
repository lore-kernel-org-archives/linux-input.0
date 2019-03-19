From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] hid: logitech: check the return value of
 create_singlethread_workqueue
Date: Tue, 19 Mar 2019 11:48:51 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903191148210.19912@cbobk.fhfr.pm>
References: <20190312100233.106098c8@lwn.net> <20190314052402.31448-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314052402.31448-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 14 Mar 2019, Kangjie Lu wrote:

> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
> Also, the fix moves the call of create_singlethread_workqueue
> earlier to avoid resource-release issues.
> 
> --
> V3: do not introduce memory leaks.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

The signoff has to be in the commit log, not in the "notes" area. I've 
fixed that and applied.

-- 
Jiri Kosina
SUSE Labs
