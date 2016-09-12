From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 1/2] ACPI / button: Fix an issue in button.lid_init_state=ignore mode
Date: Tue, 13 Sep 2016 00:10:04 +0200
Message-ID: <2178907.uJfgkT0eVn@vostro.rjw.lan>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com> <ea5573a1cf2c6b9d647f2e5a3f20cb99dd85e4d0.1471422130.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ea5573a1cf2c6b9d647f2e5a3f20cb99dd85e4d0.1471422130.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday, August 17, 2016 04:22:58 PM Lv Zheng wrote:
> On most platforms, _LID returning value, lid open/close events are all
> reliable, but there are exceptions. Some AML tables report wrong initial
> lid state (Link 1), and some of them never report lid open state (Link 2).
> The usage model on such buggy platforms is:
> 1. The initial lid state returned from _LID is not reliable;
> 2. The lid open event is not reliable;
> 3. The lid close event is always reliable, used by the platform firmware to
>    trigger OSPM power saving operations.
> This usage model is not compliant to the Linux SW_LID model as the Linux
> userspace is very strict to the reliability of the open events.
> 
> In order not to trigger issues on such buggy platforms, the ACPI button
> driver currently implements a lid_init_state=open quirk to send additional
> "open" event after resuming. However, this is still not sufficient because:
> 1. Some special usage models (e.x., the dark resume scenario) cannot be
>    supported by this mode.
> 2. If a "close" event is not used to trigger "suspend", then the subsequent
>    "close" events cannot be seen by the userspace.
> So we need to stop sending the additional "open" event and switch the
> driver to lid_init_state=ignore mode and make sure the platform triggered
> events can be reliably delivered to the userspace. The userspace programs
> then can be changed to not to be strict to the "open" events on such buggy
> platforms.
> 
> Why will the subsequent "close" events be lost? This is because the input
> layer automatically filters redundant events for switch events. Thus given
> that the buggy AML tables do not guarantee paired "open"/"close" events,
> the ACPI button driver currently is not able to guarantee that the platform
> triggered reliable events can be always be seen by the userspace via
> SW_LID.
> 
> This patch adds a mechanism to insert lid events as a compensation for the
> platform triggered ones to form a complete event switches in order to make
> sure that the platform triggered events can always be reliably delivered
> to the userspace. This essentially guarantees that the platform triggered
> reliable "close" events will always be relibly delivered to the userspace.
> 
> However this mechanism is not suitable for lid_init_state=open/method as
> it should not send the complement switch event for the unreliable initial
> lid state notification. 2 unreliable events can trigger unexpected
> behavior. Thus this patch only implements this mechanism for
> lid_init_state=ignore.
> 
> Known issues:
> 1. Possible alternative approach
>    This approach is based on the fact that Linux requires a switch event
>    type for LID events. Another approach is to use key event type to
>    implement ACPI lid events.
>    With SW event type, since ACPI button driver inserts wrong lid events,
>    there could be a potential issue that an "open" event issued from some
>    AML update methods could result in a wrong "close" event to be delivered
>    to the userspace. While using KEY event type, there is no such problem.
>    However there may not be such a kind of real case, and if there is such
>    a case, it is worked around in this patch as the complement switch event
>    is only generated for "close" event in order to deliver the reliable
>    "close" event to the userspace.
> 
> Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
>         https://bugzilla.kernel.org/show_bug.cgi?id=106151
> Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=106941
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Cc: Bastien Nocera: <hadess@hadess.net>
> Cc: linux-input@vger.kernel.org

Both the [1/2] and the [2/2] applied.

Thanks,
Rafael

